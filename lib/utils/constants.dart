import 'package:flutter/material.dart';

class AppConstants {
  // Renkler
  static const primaryColor = Color(0xFF007D41);
  static const secondaryColor = Color(0xFF99C8D8);

  // başlıklar
  static const String appName = 'LifePath';
  static const String homeTitle = 'Home';
  static const String diagnosisTitle = 'Diagnosis';
  static const String historyTitle = 'History';
  static const String profileTitle = 'Profile';

  // API Endpoints (Huawei servisleri için hazırlık)
  static const baseUrl = 'https://api.example.com'; // Daha sonra değişecek

  // Hata mesajları
  static const String invalidEmail = 'Please enter a valid email address';
  static const String invalidPassword =
      'Password must be at least 6 characters';
  static const String invalidName = 'Name must be between 2 and 50 characters';

  // Maksimum resim boyutları
  static const int maxImageWidth = 1024;
  static const int maxImageHeight = 1024;
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
}
