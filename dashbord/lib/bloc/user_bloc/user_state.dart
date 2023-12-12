part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class LoadState extends UserState {}

class ErrorUserState extends UserState {}

class UploadImageState extends UserState {
  final String url;

  UploadImageState(this.url);
}

class UploadImageCaptureState extends UserState {
  final Widget barcode;

  UploadImageCaptureState(this.barcode);
}

class SuccessUpdateState extends UserState {}

class ErrorUpdateState extends UserState {
  final String msg;

  ErrorUpdateState({required this.msg});
}

class ErrorUploadState extends UserState {
  final String msg;
  ErrorUploadState(this.msg);
}
