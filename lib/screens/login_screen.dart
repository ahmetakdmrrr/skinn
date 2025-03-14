import 'package:flutter/material.dart';
import 'Main_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skinn/utils/shared_preferences_helper.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final isLoggedIn = await SharedPreferencesHelper.isLoggedIn();
    
    if (isLoggedIn && mounted) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1)),
        child: Stack(
          children: <Widget>[
            // Background Image
            Positioned(
              top: 0,
              left: -58,
              child: Container(
                width: 528,
                height: 933,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),

            // Main Content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 220),
                      // Login Text
                      Center(
                        child: Text(
                          'Login\nSafeSkin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF007D41),
                            fontFamily: 'Poppins',
                            fontSize: 36,
                            fontWeight: FontWeight.normal,
                            height: 1,
                          ),
                        ),
                      ),
                      SizedBox(height: 60),
                      // Email Field
                      Text(
                        'E-Mail',
                        style: TextStyle(
                          color: Color.fromRGBO(47, 126, 130, 1),
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromRGBO(217, 235, 240, 1),
                        ),
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen email adresinizi girin';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                            errorStyle: TextStyle(height: 0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Password Field
                      Text(
                        'Password',
                        style: TextStyle(
                          color: Color.fromRGBO(47, 126, 130, 1),
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromRGBO(217, 235, 240, 1),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                            errorStyle: TextStyle(height: 0),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),

                      // Login Button
                      Center(
                        child: GestureDetector(
                          onTap: _handleLogin,
                          child: Container(
                            width: 151,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(102),
                              color: Color.fromRGBO(50, 129, 132, 1),
                            ),
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Don't have an account text
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Color(0xFF007D41),
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogin() async {
    // BuildContext'i final olarak saklayalım
    final context = _formKey.currentContext;
    if (context == null) return;

    if (_formKey.currentState!.validate()) {
      try {
        // Kayıtlı kullanıcı bilgilerini al
        Map<String, dynamic>? userData = await SharedPreferencesHelper.getUserData();
        
        if (userData != null && 
            userData['email'] == emailController.text && 
            userData['password'] == passwordController.text) {
          
          // Giriş başarılı
          await SharedPreferencesHelper.setLoggedIn(true);
          
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/main');
          }
        } else {
          // Giriş başarısız
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email veya şifre hatalı')),
            );
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Giriş işlemi başarısız: $e')),
          );
        }
      }
    }
  }
}
