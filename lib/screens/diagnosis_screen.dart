import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'disease_detail_screen.dart';
import 'package:skinn/services/model_service.dart';
import 'package:skinn/utils/shared_preferences_helper.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  _DiagnosisScreenState createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  final ImagePicker picker = ImagePicker();
  final ModelService _modelService = ModelService();
  String? _predictionResult;
  bool _isModelLoading = true; // Modelin yüklenme durumunu takip et

  final Map<String, Map<String, dynamic>> diseaseData = {
    'Eczema': {
      'image': 'assets/images/eczamaHand.jpg',
      'details': {
        'What is Eczema?': 'Eczema (atopic dermatitis) is a condition that makes your skin red and itchy.',
        'Causes': 'Eczema is likely related to a mix of factors: genetics, immune system dysfunction, environmental triggers.',
        'Symptoms': '• Dry, itchy skin\n• Red rashes\n• Rough patches',
        'Treatment': '• Moisturizing\n• Topical corticosteroids\n• Avoiding triggers',
        'Prevention': '• Avoid triggers\n• Keep skin moisturized\n• Manage stress',
      },
    },
    'Psoriasis': {
      'image': 'assets/images/psoriasiArm.jpg',
      'details': {
        'What is Psoriasis?': 'Psoriasis is a chronic autoimmune condition causing scaling on the skin.',
        'Causes': 'Immune system dysfunction, genetics, and environmental factors.',
        'Symptoms': '• Red patches\n• Silvery scales\n• Dry, cracked skin',
        'Treatment': '• Topical treatments\n• Light therapy\n• Systemic medications',
        'Prevention': '• Avoid triggers\n• Moisturize\n• Healthy diet',
      },
    },
    'Acne': {
      'image': 'assets/images/acneFace.jpg',
      'details': {
        'What is Acne?': 'Acne occurs when hair follicles become plugged with oil and dead skin cells.',
        'Causes': 'Clogged pores, hormones, diet, and stress.',
        'Symptoms': '• Whiteheads\n• Blackheads\n• Pimples',
        'Treatment': '• Cleansing\n• Topical medications\n• Oral medications',
        'Prevention': '• Wash face daily\n• Avoid touching face\n• Healthy diet',
      },
    },
  };

  final List<String> labels = [
    'Acne',
    'Candidiasis',
    'Eczema',
    'Psoriasis',
    'Rosacea',
  ];

  @override
  void initState() {
    super.initState();
    _loadModel(); // Modeli yükle
  }

  Future<void> _loadModel() async {
    setState(() {
      _isModelLoading = true;
    });
    await _modelService.loadModel();
    setState(() {
      _isModelLoading = false;
    });
  }

  @override
  void dispose() {
    _modelService.dispose();
    super.dispose();
  }

  Future<void> _takePhoto(BuildContext context) async {
    if (_isModelLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Model hala yükleniyor, lütfen bekleyin.')),
      );
      return;
    }
    try {
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        print("Fotoğraf çekildi: ${photo.path}");
        await _analyzeImage(photo);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kamera izni gerekli!')),
      );
    }
  }

  Future<void> _uploadPhoto(BuildContext context) async {
    if (_isModelLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Model hala yükleniyor, lütfen bekleyin.')),
      );
      return;
    }
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        print("Fotoğraf seçildi: ${image.path}");
        await _analyzeImage(image);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Galeri izni gerekli!')),
      );
    }
  }

  Future<void> _analyzeImage(XFile image) async {
    final processedImage = await _modelService.pickAndProcessImageFromFile(image.path);
    if (processedImage != null) {
      final prediction = await _modelService.runModel(processedImage);
      if (prediction != null) {
        List<MapEntry<String, double>> predictions = [];
        for (int i = 0; i < prediction.length; i++) {
          predictions.add(MapEntry(labels[i], prediction[i]));
        }
        
        predictions.sort((a, b) => b.value.compareTo(a.value));
        final top3 = predictions.take(3).toList();

        setState(() {
          _predictionResult = 'Prediction: ${top3[0].key} (${(top3[0].value * 100).toStringAsFixed(2)}%)';
        });

        if (diseaseData.containsKey(top3[0].key)) {
          // ignore: use_build_context_synchronously
            // ignore: use_build_context_synchronously
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DiseaseDetailScreen(
        title: top3[0].key,
        imagePath: diseaseData[top3[0].key]!['image'] as String,
        details: diseaseData[top3[0].key]!['details'] as Map<String, String>,
        predictions: top3,
      ),
    ),
  );
        }

        Map<String, dynamic> diagnosisData = {
          'date': DateTime.now().toIso8601String(),
          'prediction': top3[0].key,
          'confidence': top3[0].value,
        };

        _saveDiagnosis(diagnosisData);
      }
    }
  }

  void _saveDiagnosis(Map<String, dynamic> diagnosisData) async {
    // Mevcut geçmişi al
    List<Map<String, dynamic>> history = await SharedPreferencesHelper.getDiagnosisHistory();
    
    // Yeni teşhisi ekle
    history.add(diagnosisData);
    
    // Güncellenmiş geçmişi kaydet
    await SharedPreferencesHelper.saveDiagnosisHistory(history);
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
        child: SafeArea(
          child: Column(
            children: [
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
              if (_isModelLoading)
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
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
                        () => _takePhoto(context),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: _buildOptionCard(
                        context,
                        'Upload Photo',
                        Icons.photo_library,
                        'Choose photo from gallery',
                        () => _uploadPhoto(context),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              if (_predictionResult != null && !_isModelLoading)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    _predictionResult!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
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
                        'A skin condition that occurs when hair follicles become plugged.',
                        'assets/images/acneFace.jpg',
                      ),
                      _buildInfoCard(
                        context,
                        'Psoriasis',
                        'An immune-mediated disease causing red, scaly patches.',
                        'assets/images/psoriasiArm.jpg',
                      ),
                      _buildInfoCard(
                        context,
                        'Eczema',
                        'A condition that makes your skin red and itchy.',
                        'assets/images/eczamaHand.jpg',
                      ),
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
            builder: (context) => DiseaseDetailScreen(
              title: title,
              imagePath: diseaseData[title]!['image'] as String,
              details: diseaseData[title]!['details'] as Map<String, String>,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
              child: Image.asset(
                imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontFamily: 'Poppins',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}