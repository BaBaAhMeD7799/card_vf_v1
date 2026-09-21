import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LicenseService {
  // رابط سيرفر Vercel
  static const String _verifyUrl = 'https://vodacards-beta.vercel.app/api';
  static const String _storageKey = 'saved_license_key';

  /// استخراج معرف الجهاز
  static Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    }
    return 'unknown_device';
  }

  /// تفعيل كود جديد وحفظه في الذاكرة (مطلوب لـ license_screen.dart)
  static Future<Map<String, dynamic>> activateKey(String key) async {
    try {
      final deviceId = await getDeviceId();

      final response = await http.post(
        Uri.parse(_verifyUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'key': key.trim(),
          'device_id': deviceId,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        // حفظ الكود على الهاتف حتى لا يطلبه في كل مرة
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_storageKey, key.trim());

        return {
          'success': true,
          'isValid': true,
          'message': data['message'] ?? 'تم التفعيل بنجاح',
          'expires_at': data['expires_at'],
        };
      } else {
        return {
          'success': false,
          'isValid': false,
          'message': data['detail'] ?? data['message'] ?? 'فشل تفعيل الكود',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'isValid': false,
        'message': 'تعذر الاتصال بالسيرفر، تأكد من اتصال الإنترنت.',
      };
    }
  }

  /// التحقق من الكود المحفوظ تلقائياً عند فتح التطبيق (مطلوب لـ splash_screen.dart)
  static Future<Map<String, dynamic>> validateSavedKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedKey = prefs.getString(_storageKey);

      if (savedKey == null || savedKey.trim().isEmpty) {
        return {
          'success': false,
          'isValid': false,
          'message': 'لا يوجد كود تفعيل مسجل',
        };
      }

      // إعادة التحقق من الكود المحفوظ مع السيرفر للتأكد من عدم انتهاء الصلاحية
      return await activateKey(savedKey);
    } catch (e) {
      return {
        'success': false,
        'isValid': false,
        'message': 'خطأ أثناء فحص التفعيل',
      };
    }
  }
}
