import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/main_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/start_screen.dart';
import 'providers/theme_provider.dart';

Future<void> main() async {
  // Flutter binding'i başlat
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // SharedPreferences instance'ını oluştur
    final prefs = await SharedPreferences.getInstance();
    
    runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider()..initPrefs(prefs),
        child: const MyApp(),
      ),
    );
  } catch (e) {
    print('SharedPreferences error: $e');
    // Hata durumunda varsayılan tema ile başlat
    runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'SafeSkin',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          home: const Startscreen(), // StartScreen olarak düzeltildi
          routes: {
            '/login': (context) => const LoginScreen(),
            '/register': (context) => RegisterScreen(),
            '/main': (context) => MainScreen(),
          },
        );
      },
    );
  }
}
