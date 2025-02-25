import 'dart:io';
import '../services/ml/ml_service.dart';
import '../services/storage/storage_service.dart';
import '../services/service_locator.dart';

class SkinAnalysisRepository {
  final MLService _mlService;
  final StorageService _storageService;

  SkinAnalysisRepository({MLService? mlService, StorageService? storageService})
    : _mlService = mlService ?? serviceLocator<MLService>(),
      _storageService = storageService ?? serviceLocator<StorageService>();

  Future<AnalysisResult> analyzeSkinImage(File imageFile) async {
    try {
      // ML Kit ile analiz yap
      final analysisResults = await _mlService.analyzeSkin(imageFile);

      if (analysisResults.isEmpty) {
        throw Exception('Analiz sonucu bulunamadı');
      }

      // En yüksek güvenilirliğe sahip sonucu al
      final bestResult = analysisResults.reduce(
        (a, b) => a.confidence > b.confidence ? a : b,
      );

      // Resmi OBS'ye yükle
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'skin_analysis/$timestamp.jpg';
      final imageUrl = await _storageService.uploadFile(
        file: imageFile,
        path: fileName,
      );

      return AnalysisResult(
        condition: bestResult.condition,
        confidence: bestResult.confidence,
        imageUrl: imageUrl,
        recommendations: bestResult.recommendations ?? [],
        timestamp: DateTime.now(),
        additionalData: bestResult.additionalData,
      );
    } catch (e) {
      throw Exception('Analiz sırasında bir hata oluştu: $e');
    }
  }

  Future<List<AnalysisResult>> getPreviousAnalyses() async {
    try {
      final items = await _storageService.listFiles('skin_analysis/');
      List<AnalysisResult> results = [];

      for (var item in items) {
        final url = await _storageService.getDownloadUrl(item.path);
        // NOT: Gerçek implementasyonda, analiz sonuçlarını Cloud DB'de saklayıp
        // buradan çekmeniz daha doğru olacaktır.
        results.add(
          AnalysisResult(
            imageUrl: url,
            timestamp: item.lastModified ?? DateTime.now(),
            condition: 'Geçmiş Analiz',
            confidence: 0.0,
            recommendations: [],
          ),
        );
      }

      return results;
    } catch (e) {
      throw Exception('Geçmiş analizler alınırken bir hata oluştu: $e');
    }
  }
}

class AnalysisResult {
  final String condition;
  final double confidence;
  final String imageUrl;
  final List<String> recommendations;
  final DateTime timestamp;
  final Map<String, dynamic>? additionalData;

  AnalysisResult({
    required this.condition,
    required this.confidence,
    required this.imageUrl,
    required this.recommendations,
    required this.timestamp,
    this.additionalData,
  });
}
