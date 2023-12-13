import 'dart:async';
import 'package:asthma/Services/networking_api.dart';
import 'package:asthma/Services/networking_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Models/user_model.dart';
import '../../Screens/Data_Symptoms_Screen/data_ymptoms_screen.dart';
import '../../Screens/Data_Symptoms_Screen/methods/capture_symptoms.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserModel? user;
  UserBloc() : super(UserInitial()) {
    on<LoadUserDataEvent>(getData);
    on<UploadImageEvent>(saveProfileImage);
    on<UpdateUserEvent>(updateUser);
    on<UploadImageCaptureEvent>(saveCaptureImage);
  }

  FutureOr<void> getData(
      LoadUserDataEvent event, Emitter<UserState> emit) async {
    try {
      user = await getUserProfile();
      emit(LoadState());
    } catch (error) {
      emit(ErrorUserState());
    }
  }

  FutureOr<void> saveProfileImage(
      UploadImageEvent event, Emitter<UserState> emit) async {
    final supabase = SupabaseNetworking().getSupabase;
    try {
      final time = DateTime.now().millisecondsSinceEpoch;
      final idAuth = supabase.auth.currentSession!.user.id;

      // get image by id
      var list = await supabase.storage.from("profile_image").list();
      late String id;
      // search for name image
      for (var x in list) {
        if (x.name.startsWith(idAuth)) {
          id = x.name;
        }
      }
      //remove old image
      await supabase.storage.from("profile_image").remove([id]);
      //upload new image
      await supabase.storage.from('profile_image').uploadBinary(
          '$idAuth-$time.png', event.image,
          fileOptions: const FileOptions(upsert: true));
      await Future.delayed(const Duration(seconds: 1));
      // get url and saved on table user
      final upload = supabase.storage
          .from('profile_image')
          .getPublicUrl('$idAuth-$time.png');
      await supabase
          .from('users')
          .update({'image': upload}).eq('id_auth', idAuth);
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
      add(LoadUserDataEvent());
      emit(SuccessUpdateState());
    } catch (error) {
      emit(ErrorUpdateState(msg: error.toString()));
    }
  }

  FutureOr<void> saveCaptureImage(
      UploadImageCaptureEvent event, Emitter<UserState> emit) async {
    final supabase = Supabase.instance.client;
    final time = DateTime.now().millisecondsSinceEpoch;
    final idAuth = supabase.auth.currentUser!.id;
    var list = await supabase.storage.from("captrue_image").list();
    late String id;
    // search for name image
    for (var x in list) {
      if (x.name.startsWith(idAuth)) {
        id = x.name;
      }
    }
    //remove old image

    await supabase.storage.from('captrue_image').uploadBinary(
        '$idAuth-$time.png', event.image,
        fileOptions: FileOptions(upsert: true));
    final image = supabase.storage
        .from('captrue_image')
        .getPublicUrl('$idAuth-$time.png');
    if (image != '') {
      
      barcode = generateBarcode(image);
      emit(UploadImageCaptureState(barcode!));
    }
    await supabase.storage.from("captrue_image").remove([id]);
    await supabase
        .from("users")
        .update({"image_capture": image}).eq('id_auth', idAuth);
  }
}
