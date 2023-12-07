import 'dart:async';

import 'package:asthma/Services/networking_request.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../Models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserModel? user;
  UserBloc() : super(UserInitial()) {
    on<LoadUserData>(getData);
    add(LoadUserData());
  }

  FutureOr<void> getData(LoadUserData event, Emitter<UserState> emit) async {
    try {
      if (kDebugMode) {
        print("i am here 11");
      }

      user = await getUserProfile();
      await Future.delayed(const Duration(seconds: 2));
      print(user);

      if (kDebugMode) {
        print("i am here 1");
      }
      emit(LoadState());
      if (kDebugMode) {
        print("i am here hhh1");
      }
      // await Future.delayed(const Duration(seconds: 1));
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(ErrorState());
    }
  }
}
