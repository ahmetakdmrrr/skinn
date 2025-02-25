import 'package:flutter/material.dart';
import 'screens/Main_Screen.dart';
import 'screens/Login_Screen.dart';
import 'screens/Register_Screen.dart';
import 'screens/start_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter binding'i başlat
  runApp(const MyApp()); // const constructor kullan
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // const constructor ekle

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifePath',
      debugShowCheckedModeBanner: false, // Debug banner'ı kaldır
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true, // Material 3 tasarımını kullan
      ),
      home: Startscreen(), // StartScreen'i başlangıç ekranı yap
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}
