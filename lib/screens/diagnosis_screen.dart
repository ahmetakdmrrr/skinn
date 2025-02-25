import 'package:flutter/material.dart';
import 'disease_detail_screen.dart';

class DiagnosisScreen extends StatelessWidget {
  DiagnosisScreen({super.key});

  // Hastalık detayları - Normalde cloud'dan gelecek
  final Map<String, Map<String, dynamic>> diseaseData = {
    'Eczema': {
      'image': 'assets/images/eczamaHand.jpg',
      'details': {
        'What is Eczema?':
            'Eczema (atopic dermatitis) is a condition that makes your skin red and itchy. It\'s common in children but can occur at any age.',
        'Causes':
            'Eczema is likely related to a mix of factors: genetics, immune system dysfunction, environmental triggers, and stress.',
        'Symptoms':
            '• Dry, itchy skin\n• Red rashes\n• Rough, leathery patches\n• Inflammation\n• Skin swelling',
        'Treatment':
            '• Moisturizing regularly\n• Topical corticosteroids\n• Antihistamines for itching\n• Avoiding triggers\n• Using mild soaps',
        'Prevention':
            '• Identify and avoid triggers\n• Keep skin moisturized\n• Take shorter showers with warm (not hot) water\n• Use gentle soaps\n• Manage stress levels',
      },
    },
    'Psoriasis': {
      'image': 'assets/images/psoriasiArm.jpg',
      'details': {
        'What is Psoriasis?':
            'Psoriasis is a chronic autoimmune condition that causes rapid buildup of skin cells, resulting in scaling on the skin\'s surface.',
        'Causes':
            'Psoriasis occurs when your immune system sends faulty signals that speed up skin cell growth. Genetics and environmental factors play a role.',
        'Symptoms':
            '• Red patches of skin\n• Silvery scales\n• Dry, cracked skin\n• Itching and burning\n• Thick, ridged nails',
        'Treatment':
            '• Topical treatments\n• Light therapy\n• Systemic medications\n• Biologics\n• Lifestyle changes',
        'Prevention':
            '• Avoid triggers like stress\n• Keep skin moisturized\n• Avoid skin injuries\n• Eat a healthy diet\n• Get regular exercise',
      },
    },
    'Acne': {
      'image': 'assets/images/acneFace.jpg',
      'details': {
        'What is Acne?':
            'Acne is a skin condition that occurs when hair follicles become plugged with oil and dead skin cells, leading to pimples, blackheads, and whiteheads.',
        'Causes':
            'Acne occurs when pores become clogged with oil, dead skin cells, and bacteria. Hormones, diet, and stress can contribute to outbreaks.',
        'Symptoms': '• Whiteheads\n• Blackheads\n• Pimples\n• Cysts\n• Nodules',
        'Treatment':
            '• Regular cleansing\n• Topical medications\n• Oral medications\n• Chemical peels\n• Proper skincare routine',
        'Prevention':
            '• Wash face twice daily\n• Avoid touching face\n• Use non-comedogenic products\n• Maintain a healthy diet\n• Manage stress levels',
      },
    },
  };

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
        child: SafeArea(
          child: Column(
            children: [
              // Üst Başlık
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Skin Analysis',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Color(0xFF007D41),
                  ),
                ),
              ),

              // Kamera ve Galeri Seçenekleri
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildOptionCard(
                        context,
                        'Take Photo',
                        Icons.camera_alt,
                        'Use camera to analyze skin condition',
                        () {
                          // Kamera işlevselliği
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: _buildOptionCard(
                        context,
                        'Upload Photo',
                        Icons.photo_library,
                        'Choose photo from gallery',
                        () {
                          // Galeri işlevselliği
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Bilgi Kartları
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Common Skin Conditions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildInfoCard(
                        context,
                        'Acne',
                        'A skin condition that occurs when hair follicles become plugged with oil and dead skin cells. Common symptoms include whiteheads, blackheads, and pimples.',
                        'assets/images/acneFace.jpg',
                      ),
                      _buildInfoCard(
                        context,
                        'Psoriasis',
                        'An immune-mediated disease that causes raised, red, scaly patches to appear on the skin. Often affects elbows, knees, and scalp.',
                        'assets/images/psoriasiArm.jpg',
                      ),
                      _buildInfoCard(
                        context,
                        'Eczema',
                        'A condition that makes your skin red and itchy. It\'s common in children but can occur at any age. Often appears on hands, ankles, neck, and limbs.',
                        'assets/images/eczamaHand.jpg',
                      ),
                      // Daha fazla hastalık eklenebilir
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context,
    String title,
    IconData icon,
    String description,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
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
            Icon(icon, size: 40, color: Color(0xFF007D41)),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 5),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    String description,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => DiseaseDetailScreen(
                  title: title,
                  imagePath: diseaseData[title]!['image'] as String,
                  details:
                      diseaseData[title]!['details'] as Map<String, String>,
                ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(15),
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
