class UserCredentials {
  final String email;
  final String password;
  final String name;
  final String surname;
  final String? phoneNumber;
  final DateTime birthDate;
  final String? gender;
  final Map<String, dynamic>? additionalData;

  UserCredentials({
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.birthDate,
    this.phoneNumber,
    this.gender,
    this.additionalData,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'surname': surname,
      'birthDate': birthDate.toIso8601String(),
      'phoneNumber': phoneNumber,
      'gender': gender,
      'additionalData': additionalData,
    };
  }

  // Auth service için sadece kimlik doğrulama verileri
  Map<String, String> toAuthCredentials() {
    return {'email': email, 'password': password};
  }

  // Cloud DB için kullanıcı profil verileri
  Map<String, dynamic> toUserProfile() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'birthDate': birthDate.toIso8601String(),
      'phoneNumber': phoneNumber,
      'gender': gender,
      'createdAt': DateTime.now().toIso8601String(),
      'additionalData': additionalData,
    };
  }

  factory UserCredentials.fromMap(Map<String, dynamic> map) {
    return UserCredentials(
      email: map['email'],
      password: '', // Password is not stored in map for security
      name: map['name'],
      surname: map['surname'],
      birthDate: DateTime.parse(map['birthDate']),
      phoneNumber: map['phoneNumber'],
      gender: map['gender'],
      additionalData: map['additionalData'],
    );
  }
}
