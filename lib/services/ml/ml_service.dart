import 'dart:io';

abstract class MLService {
  Future<void> initialize();

  Future<List<SkinAnalysisResult>> analyzeSkin(File imageFile);

  Future<List<String>> detectLabels(File imageFile);

  Future<String> detectSkinCondition(File imageFile);
}

class SkinAnalysisResult {
  final String condition;
  final double confidence;
  final Map<String, dynamic>? additionalData;
  final List<String>? recommendations;

  SkinAnalysisResult({
    required this.condition,
    required this.confidence,
    this.additionalData,
    this.recommendations,
  });
}
