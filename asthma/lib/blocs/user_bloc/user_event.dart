part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

final class LoadUserData extends UserEvent {}

final class UploadeImageEvent extends UserEvent {
  final Uint8List image;

  UploadeImageEvent(this.image);
}
