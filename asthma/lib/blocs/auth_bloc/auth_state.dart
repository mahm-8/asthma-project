part of 'auth_bloc.dart';

abstract class AuthStates {}

class AuthInitial extends AuthStates {}

final class SignUpSuccessState extends AuthStates {}

final class ErrorAuthState extends AuthStates {
  final String message;

  ErrorAuthState(this.message);
}

class DisplayState extends AuthStates {
  final bool display;

  DisplayState({required this.display});
}

final class SignUpErrorAuthState extends AuthStates {
  final String message;

  SignUpErrorAuthState(this.message);
}

final class ErrorVerificationState extends AuthStates {
  final String message;

  ErrorVerificationState(this.message);
}

final class SuccessVerificationState extends AuthStates {}

final class LoginSuccessState extends AuthStates {}

final class LogoutSuccessState extends AuthStates {}

final class ErrorLogoutState extends AuthStates {
  final String msg;

  ErrorLogoutState(this.msg);
}

class CheckLoginState extends AuthStates {}

class ErrorCheckState extends AuthStates {}

final class ValidSignUpState extends AuthStates {}

final class ValidLoginState extends AuthStates {}
