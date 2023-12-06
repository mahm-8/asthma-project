extension ExtString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[\w-.]+@([\w-]+.)+[\w-]{2,4}$");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$");
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?05[0-9]{8}$");
    return phoneRegExp.hasMatch(this);
  }
}
