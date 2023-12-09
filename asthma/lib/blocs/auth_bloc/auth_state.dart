part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

final class SignUpSuccessState extends AuthState {}

final class ErrorState extends AuthState {
  final String message;

  ErrorState(this.message);
}

class DisplayState extends AuthState {
  final bool display;

  DisplayState({required this.display});
}

final class SignUpErrorState extends AuthState {
  final String message;

  SignUpErrorState(this.message);
}

final class ErrorVerificationState extends AuthState {
  final String message;

  ErrorVerificationState(this.message);
}

final class SuccessVerificationState extends AuthState {}

final class LoginSuccessState extends AuthState {}

final class LogoutSuccessState extends AuthState {}

final class ErrorLogoutState extends AuthState {
  final String msg;

  ErrorLogoutState(this.msg);
}

class CheckLoginState extends AuthState {}

class ErrorCheckState extends AuthState {}

final class ValidSignUpState extends AuthState {}

final class ValidLoginState extends AuthState {}
