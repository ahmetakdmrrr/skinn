import 'diagnosis_model.dart';

class DiagnosisHistory {
  final String userId;
  final List<Diagnosis> diagnoses;
  final DateTime lastUpdated;
  final Map<String, int> conditionCounts;
  final Map<String, List<String>> recommendations;

  DiagnosisHistory({
    required this.userId,
    required this.diagnoses,
    required this.lastUpdated,
    Map<String, int>? conditionCounts,
    Map<String, List<String>>? recommendations,
  }) : conditionCounts = conditionCounts ?? {},
       recommendations = recommendations ?? {};

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'diagnoses': diagnoses.map((d) => d.toMap()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'conditionCounts': conditionCounts,
      'recommendations': recommendations,
    };
  }

  factory DiagnosisHistory.fromMap(Map<String, dynamic> map) {
    return DiagnosisHistory(
      userId: map['userId'],
      diagnoses:
          (map['diagnoses'] as List).map((d) => Diagnosis.fromMap(d)).toList(),
      lastUpdated: DateTime.parse(map['lastUpdated']),
      conditionCounts: Map<String, int>.from(map['conditionCounts'] ?? {}),
      recommendations: Map<String, List<String>>.from(
        map['recommendations'] ?? {},
      ),
    );
  }

  DiagnosisHistory addDiagnosis(Diagnosis diagnosis) {
    final newDiagnoses = [...diagnoses, diagnosis];
    final newConditionCounts = Map<String, int>.from(conditionCounts);
    newConditionCounts[diagnosis.condition] =
        (newConditionCounts[diagnosis.condition] ?? 0) + 1;

    return DiagnosisHistory(
      userId: userId,
      diagnoses: newDiagnoses,
      lastUpdated: DateTime.now(),
      conditionCounts: newConditionCounts,
      recommendations: recommendations,
    );
  }

  List<Diagnosis> getDiagnosesByCondition(SkinConditionType condition) {
    return diagnoses.where((d) => d.condition == condition.toString()).toList();
  }

  List<Diagnosis> getDiagnosesByDateRange(DateTime start, DateTime end) {
    return diagnoses
        .where(
          (d) =>
              d.diagnosisDate.isAfter(start) && d.diagnosisDate.isBefore(end),
        )
        .toList();
  }
}
