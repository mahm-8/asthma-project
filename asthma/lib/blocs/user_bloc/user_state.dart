part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class LoadState extends UserState {}

class ErrorState extends UserState {}

class UploadImageState extends UserState {
  final String url;

  UploadImageState(this.url);
}

class ErrorUploadState extends UserState {
  final String msg;

  ErrorUploadState(this.msg);
}
