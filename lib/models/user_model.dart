import 'user_credentials.dart';

class User {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String? profileImage;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    this.profileImage,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  User copyWith({
    String? id,
    String? name,
    String? surname,
    String? email,
    String? profileImage,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'profileImage': profileImage,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      email: map['email'],
      profileImage: map['profileImage'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

class UserSettings {
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final String? language;
  final Map<String, dynamic>? preferences;

  UserSettings({
    this.notificationsEnabled = true,
    this.darkModeEnabled = false,
    this.language = 'tr',
    this.preferences,
  });

  Map<String, dynamic> toMap() {
    return {
      'notificationsEnabled': notificationsEnabled,
      'darkModeEnabled': darkModeEnabled,
      'language': language,
      'preferences': preferences,
    };
  }

  factory UserSettings.fromMap(Map<String, dynamic> map) {
    return UserSettings(
      notificationsEnabled: map['notificationsEnabled'] ?? true,
      darkModeEnabled: map['darkModeEnabled'] ?? false,
      language: map['language'] ?? 'tr',
      preferences: map['preferences'],
    );
  }
}
