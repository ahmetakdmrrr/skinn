import 'dart:async';
import 'package:flutter/foundation.dart';
import 'auth_service.dart';
import '../../models/user_model.dart' as models;
import '../../models/user_credentials.dart';
import '../database/database_service.dart';

class EmailAuthService implements AuthService {
  final _authStateController = StreamController<models.User?>.broadcast();
  final DatabaseService _databaseService;
  models.User? _currentUser;

  EmailAuthService({required DatabaseService databaseService})
    : _databaseService = databaseService;

  @override
  Future<void> initialize() async {
    // Yerel depolamadan mevcut oturum bilgisini kontrol et
  }

  @override
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final user = await _authenticateUser(email, password);
      _currentUser = user;
      _authStateController.add(user);

      return UserCredential(
        uid: user.id,
        email: user.email,
        displayName: '${user.name} ${user.surname}',
      );
    } catch (e) {
      throw Exception('Giriş başarısız: $e');
    }
  }

  @override
  Future<UserCredential?> register(UserCredentials credentials) async {
    try {
      // 1. Auth sisteminde kullanıcı oluştur
      final authCredentials = credentials.toAuthCredentials();
      final userId = await _createAuthUser(
        authCredentials['email']!,
        authCredentials['password']!,
      );

      // 2. Cloud DB'de kullanıcı profili oluştur
      final userProfile = credentials.toUserProfile();
      userProfile['id'] = userId; // Auth'dan gelen ID'yi ekle

      await _databaseService.createUserProfile(userProfile);

      // 3. Kullanıcıyı otomatik giriş yap
      final user = await _authenticateUser(
        credentials.email,
        credentials.password,
      );
      _currentUser = user;
      _authStateController.add(user);

      return UserCredential(
        uid: user.id,
        email: user.email,
        displayName: '${user.name} ${user.surname}',
      );
    } catch (e) {
      // Hata durumunda temizlik yap
      // - Auth'dan kullanıcıyı sil
      // - DB'den profili sil
      throw Exception('Kayıt başarısız: $e');
    }
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _authStateController.add(null);
  }

  @override
  Stream<models.User?> get authStateChanges => _authStateController.stream;

  @override
  models.User? get currentUser => _currentUser;

  Future<models.User> _authenticateUser(String email, String password) async {
    // TODO: Email/şifre doğrulaması yap
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email ve şifre boş olamaz');
    }

    // 1. Auth sisteminde doğrula
    final userId = await _verifyCredentials(email, password);

    // 2. Cloud DB'den kullanıcı profilini al
    final userProfile = await _databaseService.getUserProfile(userId);

    // 3. User nesnesini oluştur
    return models.User(
      id: userProfile['id'],
      name: userProfile['name'],
      surname: userProfile['surname'],
      email: userProfile['email'],
      createdAt: DateTime.parse(userProfile['createdAt']),
    );
  }

  Future<String> _createAuthUser(String email, String password) async {
    // TODO: Auth sisteminde yeni kullanıcı oluştur
    return 'generated_user_id';
  }

  Future<String> _verifyCredentials(String email, String password) async {
    // TODO: Auth sisteminde kimlik doğrulaması yap
    return 'verified_user_id';
  }

  @override
  void dispose() {
    _authStateController.close();
  }
}
