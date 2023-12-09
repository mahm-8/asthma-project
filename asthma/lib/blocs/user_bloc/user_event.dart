part of 'user_bloc.dart';

abstract class UserEvent {}

final class LoadUserData extends UserEvent {}

final class UploadeImageEvent extends UserEvent {
  final Uint8List image;

  UploadeImageEvent(this.image);
}

final class UpdateUserEvent extends UserEvent {
  final UserModel user;

  UpdateUserEvent({required this.user});
}
