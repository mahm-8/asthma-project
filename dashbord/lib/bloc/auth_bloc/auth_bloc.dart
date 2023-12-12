import 'dart:async';
import 'package:dashboard/model/user_model.dart';
import 'package:dashboard/services/networking_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Services/networking_api.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStates> {
  UserModel? user;
  AuthBloc() : super(AuthInitial()) {
    on<DisplayPasswordEvent>(displayPass);
    on<LogInAuthEvent>(loginMethod);
    on<CheckLoginEvent>(_check);
    on<LogoutEvent>(logoutMethod);
    add(CheckLoginEvent());
  }
  validation({required GlobalKey<FormState> keyForm}) {
    if (!keyForm.currentState!.validate()) {
      return false;
    }
    return true;
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
        user = await getUserProfile();

        if (login.user?.id != null) {
          if (user!.type == "admin") {
            emit(LoginSuccessState());
          } else {
            emit(ErrorLoginState("please used a application"));
          }
        } else if (login.user?.id == null) {
          emit(ErrorAuthState("Wrong password or email"));
        } else {
          emit(ErrorLoginState("please used a application"));
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
      user = await getUserProfile();
      if (user!.type == "admin") {
        if (token != null) {
          if (isExp) {
            await supabaseClint.auth
                .setSession(supabaseClint.auth.currentSession!.refreshToken!);
            emit(CheckLoginState());
          } else {
            emit(CheckLoginState());
          }
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
      return;
    }
  }
}
