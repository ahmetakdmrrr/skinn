class Validators {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isValidPassword(String password) {
    // En az 6 karakter, 1 büyük harf, 1 küçük harf, 1 rakam
    return password.length >= 6 &&
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])').hasMatch(password);
  }

  static bool isValidName(String name) {
    return name.length >= 2 && name.length <= 50;
  }
}
