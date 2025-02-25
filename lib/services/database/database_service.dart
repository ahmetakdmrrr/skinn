abstract class DatabaseService {
  Future<void> initialize();

  // Kullanıcı profili işlemleri
  Future<void> createUserProfile(Map<String, dynamic> userData);
  Future<Map<String, dynamic>> getUserProfile(String userId);
  Future<void> updateUserProfile(String userId, Map<String, dynamic> updates);
  Future<void> deleteUserProfile(String userId);

  // Kullanıcı ayarları
  Future<void> updateUserSettings(String userId, Map<String, dynamic> settings);
  Future<Map<String, dynamic>> getUserSettings(String userId);

  // Teşhis geçmişi
  Future<void> saveDiagnosis(String userId, Map<String, dynamic> diagnosis);
  Future<List<Map<String, dynamic>>> getDiagnosisHistory(String userId);
  Future<void> deleteDiagnosis(String userId, String diagnosisId);

  void dispose();
}

class CloudDBService implements DatabaseService {
  @override
  Future<void> initialize() async {
    // TODO: Cloud DB bağlantısını başlat
  }

  @override
  Future<void> createUserProfile(Map<String, dynamic> userData) async {
    // TODO: Cloud DB'ye yeni kullanıcı profili ekle
    // 1. Veriyi doğrula
    // 2. Cloud DB'ye kaydet
    // 3. İndeksleri güncelle
  }

  @override
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    // TODO: Cloud DB'den kullanıcı profilini getir
    return {
      'id': userId,
      'name': 'Test',
      'surname': 'User',
      'email': 'test@example.com',
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  @override
  Future<void> updateUserProfile(
    String userId,
    Map<String, dynamic> updates,
  ) async {
    // TODO: Cloud DB'de kullanıcı profilini güncelle
  }

  @override
  Future<void> deleteUserProfile(String userId) async {
    // TODO: Cloud DB'den kullanıcı profilini sil
  }

  @override
  Future<void> updateUserSettings(
    String userId,
    Map<String, dynamic> settings,
  ) async {
    // TODO: Cloud DB'de kullanıcı ayarlarını güncelle
  }

  @override
  Future<Map<String, dynamic>> getUserSettings(String userId) async {
    // TODO: Cloud DB'den kullanıcı ayarlarını getir
    return {};
  }

  @override
  Future<void> saveDiagnosis(
    String userId,
    Map<String, dynamic> diagnosis,
  ) async {
    // TODO: Cloud DB'ye teşhis kaydı ekle
  }

  @override
  Future<List<Map<String, dynamic>>> getDiagnosisHistory(String userId) async {
    // TODO: Cloud DB'den teşhis geçmişini getir
    return [];
  }

  @override
  Future<void> deleteDiagnosis(String userId, String diagnosisId) async {
    // TODO: Cloud DB'den teşhis kaydını sil
  }

  @override
  void dispose() {
    // TODO: Cloud DB bağlantısını kapat
  }
}
