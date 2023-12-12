part of 'chat_bloc.dart';


abstract class ChatEvent {}

class GetUserChatEvent extends ChatEvent {}

class GetAdminChatEvent extends ChatEvent {}

class GetScreenChatEvent extends ChatEvent {
  final int ind;

  GetScreenChatEvent(this.ind);
}

class MessageEvent extends ChatEvent {
  final String message;
  final String idUserTo;

  MessageEvent({required this.message, required this.idUserTo});
}
