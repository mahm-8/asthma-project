part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

final class ChatInitial extends ChatState {}

class GetUsersSuccessedState extends ChatState {
  final List<UserModel> users;

  GetUsersSuccessedState(this.users);
}

final class GetAdminSuccessedState extends ChatState {
  final List<UserModel> admin;

  GetAdminSuccessedState({required this.admin});
}

final class ErrorGetUsersState extends ChatState {}

class ScreenChatState extends ChatState {
  final int num;

  ScreenChatState(this.num);
}
