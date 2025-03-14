import 'package:flutter/material.dart';
import 'package:skinn/screens/main_screen.dart';  
import 'package:skinn/utils/shared_preferences_helper.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterscreenWidgetState createState() => _RegisterscreenWidgetState();
}

class _RegisterscreenWidgetState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _surnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _verifyPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                      SizedBox(height: 120), // 72'den 120'ye yükselttik
                      // Register Text
                      Center(
                        child: Text(
                          'Register\nSafeSkin',
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
                      SizedBox(height: 60), // 40'tan 60'a yükselttik
                      // Name Field
                      Text(
                        'Name',
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
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Surname Field
                      Text(
                        'Surname',
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
                        child: TextField(
                          controller: _surnameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

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
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen email adresinizi girin';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                            errorStyle: TextStyle(height: 0), // Hata mesajını gizle
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
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Verify Password Field
                      Text(
                        'Verify Password',
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
                        child: TextField(
                          controller: _verifyPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),

                      // Register Button
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            if (_passwordController.text == _verifyPasswordController.text) {
                              _handleRegister();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Şifreler eşleşmiyor')),
                              );
                            }
                          },
                          child: Container(
                            width: 151,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(102),
                              color: Color.fromRGBO(50, 129, 132, 1),
                            ),
                            child: Center(
                              child: Text(
                                'Register',
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
                      SizedBox(
                        height: 20,
                      ), // Azalttık çünkü yeni bir widget ekleyeceğiz
                      // Already have an account text
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text(
                                'Login',
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

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Kullanıcı bilgilerini hazırla
        Map<String, dynamic> userData = {
          'name': _nameController.text,
          'email': _emailController.text,
          'surname': _surnameController.text,
          'password': _passwordController.text,
        };

        // SharedPreferences'e kaydet
        await SharedPreferencesHelper.saveUserData(userData);
        await SharedPreferencesHelper.setLoggedIn(true);

        // Ana sayfaya yönlendir
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/main');
        }
      } catch (e) {
        // Hata durumunda kullanıcıyı bilgilendir
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Kayıt işlemi başarısız: $e')),
          );
        }
      }
    }
  }
}
