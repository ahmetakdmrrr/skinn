import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skinn/screens/start_screen.dart';
import '../providers/theme_provider.dart';
import '../utils/shared_preferences_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _fullName = '';
  String _email = '';
  String _birthDate = '';
  String _skinType = '';
  String _allergies = '';
  String _skinConditions = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await SharedPreferencesHelper.getUserData();
    if (userData != null) {
      setState(() {
        _fullName = userData['name'] ?? 'Not specified';
        _email = userData['email'] ?? 'Not specified';
        _birthDate = userData['birthDate'] ?? 'Not specified';
        _skinType = userData['skinType'] ?? 'Not specified';
        _allergies = userData['allergies'] ?? 'Not specified';
        _skinConditions = userData['skinConditions'] ?? 'Not specified';
      });
    }
  }

  void _handleLogout() async {
    // Logout işlemi
    await SharedPreferencesHelper.setLoggedIn(false);

    if (mounted) {
      // Tüm sayfaları temizleyip StartScreen'e yönlendir
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Startscreen()),
        (Route<dynamic> route) => false, // Tüm route'ları temizle
      );
    }
  }

  Future<void> _editProfile() async {
    // Düzenleme dialog'unu göster
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Profili Düzenle'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Ad Soyad'),
                    controller: TextEditingController(text: _fullName),
                    onChanged: (value) => _fullName = value,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Doğum Tarihi'),
                    controller: TextEditingController(text: _birthDate),
                    onChanged: (value) => _birthDate = value,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Cilt Tipi'),
                    controller: TextEditingController(text: _skinType),
                    onChanged: (value) => _skinType = value,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Alerjiler'),
                    controller: TextEditingController(text: _allergies),
                    onChanged: (value) => _allergies = value,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('İptal'),
              ),
              TextButton(
                onPressed: () async {
                  // Profil bilgilerini güncelle
                  await SharedPreferencesHelper.updateUserProfile(
                    fullName: _fullName,
                    birthDate: _birthDate,
                    skinType: _skinType,
                    allergies: _allergies,
                  );

                  if (mounted) {
                    Navigator.pop(context);
                    setState(() {}); // UI'ı yenile
                  }
                },
                child: Text('Kaydet'),
              ),
            ],
          ),
    );
  }

  Widget _buildSettingItem(String title, IconData icon, BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (title == 'Theme') {
      return ListTile(
        leading: Icon(icon, color: Color(0xFF007D41)),
        title: Text(title, style: TextStyle(fontFamily: 'Poppins')),
        trailing: Switch(
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            themeProvider.toggleTheme();
          },
          activeColor: Color(0xFF007D41),
        ),
      );
    }

    return ListTile(
      leading: Icon(icon, color: Color(0xFF007D41)),
      title: Text(title, style: TextStyle(fontFamily: 'Poppins')),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF99C8D8), Colors.white],
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
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.grey[600],
                        ),
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
                                _fullName,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                _email,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: _editProfile,
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
                        _buildDetailItem('Full Name', _fullName),
                        _buildDetailItem('Date of Birth', _birthDate),
                        _buildDetailItem('Skin Type', _skinType),
                        _buildDetailItem('Allergies', _allergies),
                        _buildDetailItem(
                          'Known Skin Conditions',
                          _skinConditions,
                        ),
                      ]),
                      _buildSection('App Settings', [
                        _buildSettingItem(
                          'Notification Settings',
                          Icons.notifications,
                          context,
                        ),
                        _buildSettingItem(
                          'Privacy Settings',
                          Icons.privacy_tip,
                          context,
                        ),
                        _buildSettingItem('Language', Icons.language, context),
                        _buildSettingItem('Theme', Icons.brightness_6, context),
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
                        onPressed: _handleLogout,
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
                        onPressed: _handleLogout,
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
            style: TextStyle(color: Colors.grey[600], fontFamily: 'Poppins'),
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
}
