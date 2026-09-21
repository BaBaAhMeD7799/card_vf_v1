import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';

class LicenseService {
  // الرابط المباشر على Vercel
  static const String _verifyUrl = 'https://vodacards-beta.vercel.app/api';

  /// استخراج معرّف الجهاز الفريد (Device ID)
  static Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // معرّف أندرويد الثابت للجهاز
    }
    return 'unknown_device';
  }

  /// التحقق من المفتاح وربطه بالجهاز
  static Future<Map<String, dynamic>> verifyLicenseKey(String key) async {
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
        return {
          'success': true,
          'message': data['message'],
          'expires_at': data['expires_at'],
        };
      } else {
        return {
          'success': false,
          'message': data['detail'] ?? data['message'] ?? 'فشل التحقق من الكود',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'تعذر الاتصال بسيرفر التحقق، تأكد من اتصال الإنترنت.',
      };
    }
  }
}
