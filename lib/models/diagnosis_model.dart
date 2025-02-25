enum SeverityLevel { mild, moderate, severe }

class Diagnosis {
  final String id;
  final String userId;
  final String imageUrl;
  final String condition;
  final SeverityLevel severity;
  final DateTime diagnosisDate;
  final Map<String, dynamic>? aiResults;

  Diagnosis({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.condition,
    required this.severity,
    required this.diagnosisDate,
    this.aiResults,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'imageUrl': imageUrl,
      'condition': condition,
      'severity': severity.toString(),
      'diagnosisDate': diagnosisDate.toIso8601String(),
      'aiResults': aiResults,
    };
  }

  factory Diagnosis.fromMap(Map<String, dynamic> map) {
    return Diagnosis(
      id: map['id'],
      userId: map['userId'],
      imageUrl: map['imageUrl'],
      condition: map['condition'],
      severity: SeverityLevel.values.firstWhere(
        (e) => e.toString() == map['severity'],
        orElse: () => SeverityLevel.mild,
      ),
      diagnosisDate: DateTime.parse(map['diagnosisDate']),
      aiResults: map['aiResults'],
    );
  }
}

// Hastalık tipleri için enum
enum SkinConditionType { eczema, psoriasis, acne, melanoma, other }
