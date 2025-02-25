import 'package:flutter/material.dart';

class Startscreen extends StatefulWidget {
  const Startscreen({super.key});

  @override
  _StartscreenState createState() => _StartscreenState();
}

class _StartscreenState extends State<Startscreen> {
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 150), // Logo için daha fazla boşluk bırakıldı
                // Logo Image
                Container(
                  width: 160,
                  height: 151,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(height: 18), // Spacing between logo and text
                // Welcome Text
                Text(
                  'Welcome\nSafeSkin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black, // Fixed undefined color
                    fontFamily: 'Poppins',
                    fontSize: 36,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
                Spacer(), // Pushes the buttons to the bottom
                // Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Login Button
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Container(
                        width: 154,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(102),
                          color: Color.fromRGBO(47, 126, 127, 1),
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              height: 1.43,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 29), // Spacing between buttons
                    // Register Button
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Container(
                        width: 151,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(102),
                          color: Color.fromRGBO(190, 215, 220, 1),
                        ),
                        child: Center(
                          child: Text(
                            'Register',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40), // Spacing from the bottom
              ],
            ),
          ],
        ),
      ),
    );
  }
}
