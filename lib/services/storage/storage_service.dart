import 'dart:convert';
import 'dart:io';
import '../../models/user_model.dart';
import '../../models/diagnosis_history.dart';
import '../../models/diagnosis_model.dart';

abstract class StorageService {
  Future<void> initialize();

  // Dosya işlemleri
  Future<String> uploadFile({
    required File file,
    required String path,
    void Function(double progress)? onProgress,
  });
  Future<void> deleteFile(String path);
  Future<String> getDownloadUrl(String path);
  Future<List<StorageItem>> listFiles(String path);

  // Kullanıcı işlemleri
  Future<void> saveUser(User user);
  Future<User?> getUser(String userId);
  Future<void> deleteUser(String userId);
  Future<void> updateUserSettings(String userId, UserSettings settings);

  // Teşhis işlemleri
  Future<void> saveDiagnosis(String userId, Diagnosis diagnosis);
  Future<DiagnosisHistory?> getDiagnosisHistory(String userId);
  Future<void> deleteDiagnosis(String userId, String diagnosisId);

  void dispose();
}

class OBSStorageService implements StorageService {
  static const String USERS_PATH = 'users';
  static const String DIAGNOSIS_PATH = 'diagnoses';
  static const String IMAGES_PATH = 'images';

  @override
  Future<void> initialize() async {
    // TODO: OBS servisini başlat
  }

  @override
  Future<String> uploadFile({
    required File file,
    required String path,
    void Function(double progress)? onProgress,
  }) async {
    // TODO: OBS'ye dosya yükle
    return 'https://obs.example.com/$path';
  }

  @override
  Future<void> deleteFile(String path) async {
    // TODO: OBS'den dosya sil
  }

  @override
  Future<String> getDownloadUrl(String path) async {
    // TODO: OBS'den dosya URL'i al
    return 'https://obs.example.com/$path';
  }

  @override
  Future<List<StorageItem>> listFiles(String path) async {
    // TODO: OBS'den dosya listesi al
    return [];
  }

  @override
  Future<void> saveUser(User user) async {
    final jsonData = jsonEncode(user.toMap());
    final userFile = File.fromRawPath(utf8.encode(jsonData));

    // Kullanıcı JSON dosyasını OBS'ye kaydet
    await uploadFile(file: userFile, path: '$USERS_PATH/${user.id}.json');

    // Profil resmi varsa kaydet
    if (user.profileImage != null && user.profileImage!.startsWith('file://')) {
      final imageFile = File(user.profileImage!.replaceFirst('file://', ''));
      final imageUrl = await uploadFile(
        file: imageFile,
        path: '$IMAGES_PATH/${user.id}/profile.jpg',
      );

      // Profil resmini güncelle
      final updatedUser = user.copyWith(profileImage: imageUrl);
      await saveUser(updatedUser);
    }
  }

  @override
  Future<User?> getUser(String userId) async {
    try {
      final url = await getDownloadUrl('$USERS_PATH/$userId.json');
      // TODO: URL'den JSON dosyasını indir ve parse et
      final map = {
        'id': userId,
        'name': 'Test',
        'surname': 'User',
        'email': 'test@example.com',
        'profileImage': null,
        'createdAt': DateTime.now().toIso8601String(),
      };
      return User.fromMap(map);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    await deleteFile('$USERS_PATH/$userId.json');
    // Profil resmini de sil
    await deleteFile('$IMAGES_PATH/$userId/profile.jpg');
  }

  @override
  Future<void> saveDiagnosis(String userId, Diagnosis diagnosis) async {
    // Önce teşhis geçmişini al
    var history = await getDiagnosisHistory(userId);
    if (history == null) {
      // Yeni geçmiş oluştur
      history = DiagnosisHistory(
        userId: userId,
        diagnoses: [],
        lastUpdated: DateTime.now(),
      );
    }

    // Teşhisi geçmişe ekle
    final updatedHistory = history.addDiagnosis(diagnosis);

    // Teşhis resmini kaydet
    if (diagnosis.imageUrl != null &&
        diagnosis.imageUrl!.startsWith('file://')) {
      final imageFile = File(diagnosis.imageUrl!.replaceFirst('file://', ''));
      final imageUrl = await uploadFile(
        file: imageFile,
        path: '$IMAGES_PATH/$userId/${diagnosis.id}.jpg',
      );

      // Resim URL'ini güncelle
      final updatedDiagnosis = Diagnosis(
        id: diagnosis.id,
        userId: diagnosis.userId,
        condition: diagnosis.condition,
        imageUrl: imageUrl,
        severity: diagnosis.severity,
        diagnosisDate: diagnosis.diagnosisDate,
      );
      final finalHistory = updatedHistory.addDiagnosis(updatedDiagnosis);

      // Güncellenmiş geçmişi kaydet
      final jsonData = jsonEncode(finalHistory.toMap());
      final historyFile = File.fromRawPath(utf8.encode(jsonData));
      await uploadFile(
        file: historyFile,
        path: '$DIAGNOSIS_PATH/$userId/history.json',
      );
    }
  }

  @override
  Future<DiagnosisHistory?> getDiagnosisHistory(String userId) async {
    try {
      final url = await getDownloadUrl('$DIAGNOSIS_PATH/$userId/history.json');
      // TODO: URL'den JSON dosyasını indir ve parse et
      final map = {
        'userId': userId,
        'diagnoses': [],
        'lastUpdated': DateTime.now().toIso8601String(),
        'conditionCounts': {},
        'recommendations': {},
      };
      return DiagnosisHistory.fromMap(map);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteDiagnosis(String userId, String diagnosisId) async {
    final history = await getDiagnosisHistory(userId);
    if (history != null) {
      // Teşhisi geçmişten çıkar
      final updatedDiagnoses =
          history.diagnoses.where((d) => d.id != diagnosisId).toList();

      // Yeni geçmişi oluştur
      final updatedHistory = DiagnosisHistory(
        userId: userId,
        diagnoses: updatedDiagnoses,
        lastUpdated: DateTime.now(),
      );

      // Güncellenmiş geçmişi kaydet
      final jsonData = jsonEncode(updatedHistory.toMap());
      final historyFile = File.fromRawPath(utf8.encode(jsonData));
      await uploadFile(
        file: historyFile,
        path: '$DIAGNOSIS_PATH/$userId/history.json',
      );

      // Teşhis resmini sil
      await deleteFile('$IMAGES_PATH/$userId/$diagnosisId.jpg');
    }
  }

  @override
  Future<void> updateUserSettings(String userId, UserSettings settings) async {
    // Bu metod artık kullanılmıyor
    return;
  }

  @override
  void dispose() {
    // TODO: OBS bağlantısını kapat
  }
}

class StorageItem {
  final String name;
  final String path;
  final DateTime? lastModified;
  final int? size;

  StorageItem({
    required this.name,
    required this.path,
    this.lastModified,
    this.size,
  });
}
