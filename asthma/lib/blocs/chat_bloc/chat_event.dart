part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class GetUserChatEvent extends ChatEvent {}

class MessageEvent extends ChatEvent {
  final String message;
  final String idUserTo;

  MessageEvent({required this.message, required this.idUserTo});
}
