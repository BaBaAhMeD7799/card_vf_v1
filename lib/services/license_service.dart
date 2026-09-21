import 'package:shared_preferences/shared_preferences.dart';

class LicenseResult {
  final bool success;
  final String? message;
  final bool isConnectionError;

  const LicenseResult({
    required this.success,
    this.message,
    this.isConnectionError = false,
  });
}

class LicenseService {
  static const String _savedKeyPref = 'saved_license_key';

  // قبول أي كود يتم إدخاله وحفظه محلياً فوراً
  static Future<LicenseResult> activateKey(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_savedKeyPref, key.trim().isNotEmpty ? key.trim() : 'VIP_KEY');
      return const LicenseResult(success: true);
    } catch (_) {
      return const LicenseResult(success: true);
    }
  }

  // تخطي الفحص عند فتح التطبيق والاعتماد دائماً على أنه مفعل
  static Future<LicenseResult> validateSavedKey() async {
    return const LicenseResult(success: true);
  }

  static Future<String?> getSavedKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_savedKeyPref) ?? 'VIP_KEY';
  }

  static Future<String?> getRegisteredKey() async {
    return getSavedKey();
  }
}
