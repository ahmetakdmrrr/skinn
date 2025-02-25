import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  late SharedPreferences _prefs;

  // SharedPreferences instance'ını al
  void initPrefs(SharedPreferences? prefs) {
    if (prefs != null) {
      _prefs = prefs;
      _loadThemeFromPrefs();
    }
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveThemeToPrefs();
    notifyListeners();
  }

  void _loadThemeFromPrefs() {
    try {
      _isDarkMode = _prefs.getBool('isDarkMode') ?? false;
      notifyListeners();
    } catch (e) {
      print('Error loading theme: $e');
      _isDarkMode = false;
    }
  }

  Future<void> _saveThemeToPrefs() async {
    try {
      await _prefs.setBool('isDarkMode', _isDarkMode);
    } catch (e) {
      print('Error saving theme: $e');
    }
  }

  ThemeData get themeData {
    return _isDarkMode ? _darkTheme : _lightTheme;
  }

  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF007D41),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.light(
      primary: Color(0xFF007D41),
      secondary: Color(0xFF99C8D8),
    ),
  );

  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF007D41),
    scaffoldBackgroundColor: Color(0xFF121212),
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF007D41),
      secondary: Color(0xFF99C8D8),
    ),
  );
}
