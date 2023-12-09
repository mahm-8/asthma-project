import 'dart:async';
import 'package:asthma/Services/networking_api.dart';
import 'package:asthma/Services/networking_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Models/user_model.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserModel? user;
  UserBloc() : super(UserInitial()) {
    on<LoadUserData>(getData);
    on<UploadeImageEvent>(saveProfileImage);
    on<UpdateUserEvent>(updateUser);
    add(LoadUserData());
  }

  FutureOr<void> getData(LoadUserData event, Emitter<UserState> emit) async {
    try {
      print("===================Load Date==================");
      user = await getUserProfile();
      // await Future.delayed(const Duration(seconds: 2));
      print(user);
      print("===================get Date==================");
      emit(LoadState());
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(ErrorState());
    }
  }

  FutureOr<void> saveProfileImage(
      UploadeImageEvent event, Emitter<UserState> emit) async {
    final supabase = SupabaseNetworking().getSupabase;
    try {
      final idAuth = supabase.auth.currentSession!.user.id;
      await supabase.storage.from('profile_image').uploadBinary(
          '$idAuth/profile.png', event.image,
          fileOptions: const FileOptions(upsert: true));
      await Future.delayed(const Duration(seconds: 5));
      final upload = supabase.storage
          .from('profile_image')
          .getPublicUrl('$idAuth/profile.png');

      await supabase
          .from('users')
          .update({'image': upload}).eq('id_auth', idAuth);

      print(upload);
      emit(UploadImageState(upload));
    } on StorageException catch (e) {
      emit(ErrorUploadState(e.message));
    } catch (error) {
      emit(ErrorUploadState(error.toString()));
    }
  }

  FutureOr<void> updateUser(
      UpdateUserEvent event, Emitter<UserState> emit) async {
    final supabase = SupabaseNetworking().getSupabase;
    try {
      final idAuth = supabase.auth.currentUser!.id;
      await supabase.from('users').update({
        "name": event.user.name,
        "dob": event.user.dob,
        "gender": event.user.gender,
        "phone": event.user.phone,
        "age": event.user.age!
      }).eq('id_auth', idAuth);

      print(user);
      add(LoadUserData());
      emit(SuccessUpdateState());
    } catch (error) {
      emit(ErrorUpdateState(msg: error.toString()));
    }
  }
}
