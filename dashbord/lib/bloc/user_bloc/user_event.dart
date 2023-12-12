part of 'user_bloc.dart';

abstract class UserEvent {}

final class LoadUserDataEvent extends UserEvent {}

final class UploadImageEvent extends UserEvent {
  final Uint8List image;

  UploadImageEvent(this.image);
}

final class UploadImageCaptureEvent extends UserEvent {
  final Uint8List image;

  UploadImageCaptureEvent(this.image);
}

final class UpdateUserEvent extends UserEvent {
  final UserModel user;

  UpdateUserEvent({required this.user});
}
