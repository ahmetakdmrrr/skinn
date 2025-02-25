import '../../models/user_model.dart' as models;
import '../../models/user_credentials.dart';

abstract class AuthService {
  Future<void> initialize();
  Future<UserCredential?> signIn(String email, String password);
  Future<void> signOut();
  Future<UserCredential?> register(UserCredentials credentials);
  Stream<models.User?> get authStateChanges;
  models.User? get currentUser;
  void dispose();
}

class UserCredential {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoURL;

  UserCredential({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoURL,
  });
}

class User {
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoURL;

  User({required this.uid, this.displayName, this.email, this.photoURL});
}
