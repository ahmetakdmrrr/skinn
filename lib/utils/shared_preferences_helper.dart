import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String KEY_IS_LOGGED_IN = "isLoggedIn";
  static const String KEY_USER_DATA = "userData";
  static const String KEY_DIAGNOSIS_HISTORY = "diagnosisHistory";

  // Kullanıcı giriş durumunu kaydetme
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(KEY_IS_LOGGED_IN, value);
  }

  // Kullanıcı giriş durumunu kontrol etme
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KEY_IS_LOGGED_IN) ?? false;
  }

  // Kullanıcı bilgilerini kaydetme
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_USER_DATA, jsonEncode(userData));
  }

  // Kullanıcı bilgilerini alma
  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString(KEY_USER_DATA);
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return null;
  }

  // Teşhis geçmişini kaydetme
  static Future<void> saveDiagnosisHistory(List<Map<String, dynamic>> history) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_DIAGNOSIS_HISTORY, jsonEncode(history));
  }

  // Teşhis geçmişini alma
  static Future<List<Map<String, dynamic>>> getDiagnosisHistory() async {
    final prefs = await SharedPreferences.getInstance();
    String? historyString = prefs.getString(KEY_DIAGNOSIS_HISTORY);
    if (historyString != null) {
      List<dynamic> decodedList = jsonDecode(historyString);
      return decodedList.cast<Map<String, dynamic>>();
    }
    return [];
  }

  // Çıkış yapma - tüm verileri temizleme
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
} 