import 'dart:async';

import 'package:asthma/Models/user_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Services/networking_api.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserModel? user;
  AuthBloc() : super(AuthInitial()) {
    on<SignUpAuthEvent>(signUpMethod);
    on<DisplayPasswordEvent>((event, emit) {
      if (event.display == true) {
        event.display = false;
        emit(DisplayState(display: event.display));
      } else {
        event.display = true;
        emit(DisplayState(display: event.display));
      }
    });
    on<LogInAuthEvent>(loginMethod);
    on<VerificationEvent>(verificationMethod);
  }
  validation({required GlobalKey<FormState> keyForm}) {
    if (!keyForm.currentState!.validate()) {
      return false;
    }
    return true;
  }

  signUpMethod(SignUpAuthEvent event, emit) async {
    List<bool> isValidation = [];
    try {
      isValidation.add(validation(keyForm: event.emailKey));
      isValidation.add(validation(keyForm: event.passwordKey));
      isValidation.add(validation(keyForm: event.phoneKey));
      isValidation.add(validation(keyForm: event.userNameKey));
      if (!isValidation.contains(false)) {
        final auth = SupabaseNetworking().getSupabase.auth;
        auth.signUp(email: event.email, password: event.password);

        user = UserModel(
          name: event.userName,
          email: event.email,
          phone: event.phone,
        );
        emit(SignUpSuccessState());
      }
    } catch (e) {
      return;
    }
  }

  FutureOr<void> verificationMethod(
      VerificationEvent event, Emitter<AuthState> emit) async {
    try {
      final auth = SupabaseNetworking().getSupabase.auth;
      final verification = await auth.verifyOTP(
          token: event.otp, type: OtpType.signup, email: event.email);
      if (verification.session?.accessToken != null) {
        await Future.delayed(const Duration(seconds: 1));
        await SupabaseNetworking().getSupabase.from("users").insert({
          "name": user?.name,
          "email": user?.email,
          "id_auth": verification.user!.id,
          "phone": user?.phone,
        }).select();

        emit(SuccessVerificationState());
      } else {
        emit(ErrorVerificationState("Error Pin"));
      }
    } on AuthException catch (e) {
      emit(ErrorVerificationState(e.message));
    } on PostgrestException catch (e) {
      emit(ErrorVerificationState(e.message));
    } catch (e) {
      emit(ErrorVerificationState(e.toString()));
    }
  }

  FutureOr<void> loginMethod(
      LogInAuthEvent event, Emitter<AuthState> emit) async {
    List<bool> isValidation = [];
    try {
      isValidation.add(validation(keyForm: event.emailKey));
      isValidation.add(validation(keyForm: event.passwordKey));
      if (!isValidation.contains(false)) {
        final auth = SupabaseNetworking().getSupabase.auth;
        final login = await auth.signInWithPassword(
            email: event.email, password: event.password);
        if (login.user?.id != null) {
          emit(LoginSuccessState());
        } else if (login.user?.id == null) {
          emit(ErrorState("Wrong!!!!1"));
        }
      }
    } on AuthException catch (e) {
      emit(ErrorState("Password or email wrong"));
    } catch (e) {
      emit(ErrorState("bgh"));
    }
  }
}
