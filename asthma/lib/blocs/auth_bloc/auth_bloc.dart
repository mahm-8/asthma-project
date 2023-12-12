import 'dart:async';

import 'package:asthma/Models/user_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Services/networking_api.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStates> {
  UserModel? user;
  AuthBloc() : super(AuthInitial()) {
    on<SignUpAuthEvent>(signUpMethod);
    on<DisplayPasswordEvent>(displayPass);
    on<LogInAuthEvent>(loginMethod);
    on<VerificationEvent>(verificationMethod);
    on<CheckLoginEvent>(_check);
    on<LogoutEvent>(logoutMethod);
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
      } else {
        emit(ValidSignUpState());
      }
    } catch (e) {
      return;
    }
  }

  FutureOr<void> verificationMethod(
      VerificationEvent event, Emitter<AuthStates> emit) async {
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
      LogInAuthEvent event, Emitter<AuthStates> emit) async {
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
          emit(ErrorAuthState("Wrong!!!!1"));
        }
      } else {
        emit(ValidLoginState());
      }
    } on AuthException {
      emit(ErrorAuthState("Password or email wrong"));
    } catch (e) {
      return;
    }
  }

  FutureOr<void> _check(CheckLoginEvent event, Emitter<AuthStates> emit) async {
    final supabaseClint = SupabaseNetworking().getSupabase;
    await Future.delayed(const Duration(seconds: 1));
    if (supabaseClint.auth.currentUser?.emailConfirmedAt != null) {
      final token = supabaseClint.auth.currentSession?.accessToken;
      final isExp = supabaseClint.auth.currentSession!.isExpired;
      if (token != null) {
        if (isExp) {
          await supabaseClint.auth
              .setSession(supabaseClint.auth.currentSession!.refreshToken!);
          emit(CheckLoginState());
        } else {
          emit(CheckLoginState());
        }
      } else {
        emit(ErrorCheckState());
      }
    } else {
      emit(ErrorCheckState());
    }
  }

  FutureOr<void> displayPass(
      DisplayPasswordEvent event, Emitter<AuthStates> emit) {
    if (event.display == true) {
      event.display = false;
      emit(DisplayState(display: event.display));
    } else {
      event.display = true;
      emit(DisplayState(display: event.display));
    }
  }

  FutureOr<void> logoutMethod(
      LogoutEvent event, Emitter<AuthStates> emit) async {
    try {
      final supabase = SupabaseNetworking().getSupabase;
      await supabase.auth.signOut();
      emit(LogoutSuccessState());
    } catch (error) {
      emit(ErrorLogoutState(error.toString()));
    }
  }
}
