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

  // Kullanıcı profil bilgilerini güncelleme
  static Future<void> updateUserProfile({
    String? fullName,
    String? birthDate,
    String? skinType,
    String? allergies,
    String? skinConditions,
  }) async {
    Map<String, dynamic>? currentData = await getUserData();
    Map<String, dynamic> newData = currentData ?? {};
    
    if (fullName != null) newData['fullName'] = fullName;
    if (birthDate != null) newData['birthDate'] = birthDate;
    if (skinType != null) newData['skinType'] = skinType;
    if (allergies != null) newData['allergies'] = allergies;
    if (skinConditions != null) newData['skinConditions'] = skinConditions;
    
    await saveUserData(newData);
  }

  // Teşhis sonucunu kaydetme ve skin conditions'ı güncelleme
  static Future<void> addDiagnosis(Map<String, dynamic> diagnosis) async {
    // Mevcut teşhis geçmişini al
    List<Map<String, dynamic>> history = await getDiagnosisHistory();
    history.insert(0, diagnosis); // Yeni teşhisi başa ekle
    
    // Teşhis geçmişini kaydet
    await saveDiagnosisHistory(history);
    
    // Kullanıcı bilgilerini güncelle
    Map<String, dynamic>? userData = await getUserData();
    if (userData != null) {
      // En son teşhis edilen durumu skin conditions olarak kaydet
      userData['skinConditions'] = diagnosis['condition'];
      await saveUserData(userData);
    }
  }
} 