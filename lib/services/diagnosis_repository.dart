import 'package:shared_preferences/shared_preferences.dart';

class DiagnosisResult {
  final String imagePath;
  final String diagnosis;
  final double confidence;
  final DateTime timestamp;

  DiagnosisResult({
    required this.imagePath,
    required this.diagnosis,
    required this.confidence,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'imagePath': imagePath,
    'diagnosis': diagnosis,
    'confidence': confidence,
    'timestamp': timestamp.toIso8601String(),
  };

  factory DiagnosisResult.fromJson(Map<String, dynamic> json) => DiagnosisResult(
    imagePath: json['imagePath'],
    diagnosis: json['diagnosis'],
    confidence: json['confidence'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}

class DiagnosisRepository {
  static final DiagnosisRepository _instance = DiagnosisRepository._internal();
  List<DiagnosisResult> _recentDiagnoses = [];
  
  factory DiagnosisRepository() {
    return _instance;
  }

  DiagnosisRepository._internal();

  Future<void> saveDiagnosis(DiagnosisResult result) async {
    _recentDiagnoses.insert(0, result);
    if (_recentDiagnoses.length > 10) {
      _recentDiagnoses.removeLast();
    }
    await _saveToPrefs();
  }

  List<DiagnosisResult> getRecentDiagnoses() {
    return List.unmodifiable(_recentDiagnoses);
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _recentDiagnoses.map((result) => result.toJson()).toList();
    await prefs.setString('recent_diagnoses', jsonList.toString());
  }

  Future<void> loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString('recent_diagnoses');
      
      if (jsonString != null) {
        final List<dynamic> jsonList = jsonString as List;
        _recentDiagnoses = jsonList
            .map((json) => DiagnosisResult.fromJson(json))
            .toList();
      }
    } catch (e) {
      print('Geçmiş tanılar yüklenirken hata: $e');
    }
  }
}