import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// كائن يمثل نتيجة فحص وتفعيل الترخيص
class LicenseResult {
  final bool success;
  final String message;
  final bool isConnectionError;
  final String? expiresAt;

  LicenseResult({
    required this.success,
    required this.message,
    this.isConnectionError = false,
    this.expiresAt,
  });
}

class LicenseService {
  // الرابط الخاص بسيرفر Vercel
  static const String _verifyUrl = 'https://vodacards-beta.vercel.app/api';
  static const String _storageKey = 'saved_license_key';

  /// استخراج معرّف الجهاز الثابت
  static Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    }
    return 'unknown_device';
  }

  /// تفعيل كود ترخيص جديد وربطه بالجهاز
  static Future<LicenseResult> activateKey(String key) async {
    try {
      final deviceId = await getDeviceId();

      final response = await http.post(
        Uri.parse(_verifyUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'key': key.trim(),
          'device_id': deviceId,
        }),
      ).timeout(const Duration(seconds: 12));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        // حفظ الكود الصالح محلياً على الهاتف
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_storageKey, key.trim());

        return LicenseResult(
          success: true,
          message: data['message'] ?? 'تم التفعيل بنجاح',
          expiresAt: data['expires_at'],
          isConnectionError: false,
        );
      } else {
        return LicenseResult(
          success: false,
          message: data['detail'] ?? data['message'] ?? 'فشل التحقق من الكود',
          isConnectionError: false,
        );
      }
    } on SocketException {
      return LicenseResult(
        success: false,
        message: 'تعذر الاتصال بالسيرفر، تأكد من اتصال الإنترنت.',
        isConnectionError: true,
      );
    } catch (e) {
      return LicenseResult(
        success: false,
        message: 'خطأ في الاتصال بالسيرفر: $e',
        isConnectionError: true,
      );
    }
  }

  /// فحص الكود المحفوظ تلقائياً عند فتح شاشة البداية (Splash Screen)
  static Future<LicenseResult> validateSavedKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedKey = prefs.getString(_storageKey);

      if (savedKey == null || savedKey.trim().isEmpty) {
        return LicenseResult(
          success: false,
          message: 'لا يوجد كود تفعيل مسجل',
          isConnectionError: false,
        );
      }

      // التحقق الفعلي من الكود مع السيرفر للتأكد من سريانه
      return await activateKey(savedKey);
    } catch (e) {
      return LicenseResult(
        success: false,
        message: 'حدث خطأ أثناء فحص البيانات المحفوظة',
        isConnectionError: false,
      );
    }
  }
}
