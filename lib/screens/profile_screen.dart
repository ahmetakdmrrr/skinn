import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF99C8D8),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                // Top Section - Profile Picture & Basic Info
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.person, size: 50, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Change Photo',
                          style: TextStyle(
                            color: Color(0xFF007D41),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'John Doe',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                'john.doe@example.com',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                            color: Color(0xFF007D41),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Middle Section - Personal Details & Settings
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildSection('Personal Details', [
                        _buildDetailItem('Full Name', 'John Doe'),
                        _buildDetailItem('Date of Birth', '01/01/1990'),
                        _buildDetailItem('Skin Type', 'Combination'),
                        _buildDetailItem('Allergies', 'None'),
                        _buildDetailItem('Known Skin Conditions', 'None'),
                      ]),
                      _buildSection('App Settings', [
                        _buildSettingItem('Notification Settings', Icons.notifications),
                        _buildSettingItem('Privacy Settings', Icons.privacy_tip),
                        _buildSettingItem('Language', Icons.language),
                        _buildSettingItem('Theme', Icons.brightness_6),
                      ]),
                    ],
                  ),
                ),

                // Bottom Section - Logout & Additional Actions
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF007D41),
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Contact Dermatologist',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () {
                          // Implement logout logic
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Logout',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF007D41)),
      title: Text(
        title,
        style: TextStyle(fontFamily: 'Poppins'),
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}