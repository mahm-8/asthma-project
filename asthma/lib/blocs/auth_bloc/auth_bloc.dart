import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignUpAuthEvent>((event, emit) async {
      List<bool> isValidation = [];
      try {
        isValidation.add(validation(keyForm: event.emailKey));
        isValidation.add(validation(keyForm: event.passwordKey));
        isValidation.add(validation(keyForm: event.phoneKey));
        isValidation.add(validation(keyForm: event.userNameKey));
        if (!isValidation.contains(false)) {
          emit(SignUpSuccessState());
        }
      } catch (e) {
        return;
      }
    });
    on<DisplayPasswordEvent>((event, emit) {
      if (event.display == true) {
        event.display = false;
        emit(DisplayState(display: event.display));
      } else {
        event.display = true;
        emit(DisplayState(display: event.display));
      }
    });
    on<LogInAuthEvent>((event, emit) async {
      List<bool> isValidation = [];
      isValidation.add(validation(keyForm: event.emailKey));
      isValidation.add(validation(keyForm: event.passwordKey));
      if (!isValidation.contains(false)) {
        emit(LoginSuccessState());
        try {} catch (e) {
          return;
        }
      }
    });
    on<VerificationEvent>((event, emit) async {});
  }
  validation({required GlobalKey<FormState> keyForm}) {
    if (!keyForm.currentState!.validate()) {
      return false;
    }
    return true;
  }
}
