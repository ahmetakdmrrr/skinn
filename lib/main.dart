import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/start_screen.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'SafeSkin',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.themeData,
            home: const Startscreen(),
            routes: {
              '/login': (context) => const LoginScreen(),
              '/register': (context) => RegisterScreen(),
              '/main': (context) =>  MainScreen(),
            },
          );
        },
      ),
    );
  }
}
