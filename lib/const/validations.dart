class MyValidators {
  static String? arabicValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter text';
    }
    if (RegExp(r'^[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\s]+$').hasMatch(value)) {
      return 'Please enter valid Arabic text';
    }
    return null;
  }

  static String? englishValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter text';
    }
    if (RegExp(r'^[a-zA-Z0-9\s.,]+$').hasMatch(value)) {
      return 'Please enter valid Arabic text';
    }
    return null;
  }
}