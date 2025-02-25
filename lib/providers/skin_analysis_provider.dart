import 'dart:io';
import 'package:flutter/foundation.dart';
import '../repositories/skin_analysis_repository.dart';

class SkinAnalysisProvider extends ChangeNotifier {
  final SkinAnalysisRepository _repository;

  bool _isLoading = false;
  String? _error;
  AnalysisResult? _currentAnalysis;
  List<AnalysisResult> _previousAnalyses = [];

  SkinAnalysisProvider({required SkinAnalysisRepository repository})
    : _repository = repository {
    _loadPreviousAnalyses();
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  AnalysisResult? get currentAnalysis => _currentAnalysis;
  List<AnalysisResult> get previousAnalyses => _previousAnalyses;

  Future<void> analyzeSkinImage(File imageFile) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _currentAnalysis = await _repository.analyzeSkinImage(imageFile);
      await _loadPreviousAnalyses(); // Geçmiş analizleri yenile
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadPreviousAnalyses() async {
    try {
      _previousAnalyses = await _repository.getPreviousAnalyses();
      notifyListeners();
    } catch (e) {
      _error = 'Geçmiş analizler yüklenirken bir hata oluştu: $e';
      notifyListeners();
    }
  }

  void clearCurrentAnalysis() {
    _currentAnalysis = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
