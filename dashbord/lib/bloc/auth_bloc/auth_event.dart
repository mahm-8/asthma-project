part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignUpAuthEvent extends AuthEvent {
  final String userName;
  final String email;
  final String password;
  final String phone;
  final GlobalKey<FormState> userNameKey;
  final GlobalKey<FormState> emailKey;
  final GlobalKey<FormState> passwordKey;
  final GlobalKey<FormState> phoneKey;

  SignUpAuthEvent(this.userName, this.email, this.password, this.phone,
      this.userNameKey, this.emailKey, this.passwordKey, this.phoneKey);
}

class DisplayPasswordEvent extends AuthEvent {
  bool display;

  DisplayPasswordEvent(this.display);
}

class LogInAuthEvent extends AuthEvent {
  final String email;
  final String password;
  final GlobalKey<FormState> emailKey;
  final GlobalKey<FormState> passwordKey;
  LogInAuthEvent(
      {required this.email,
      required this.password,
      required this.emailKey,
      required this.passwordKey});
}

class VerificationEvent extends AuthEvent {
  final String otp;
  final String email;

  VerificationEvent({
    required this.otp,
    required this.email,
  });
}

class CheckLoginEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
