import 'dart:async';

import 'package:dashboard/model/message_model.dart';
import 'package:dashboard/model/user_model.dart';
import 'package:dashboard/services/networking_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<GetUserChatEvent>(getUsers);
    on<MessageEvent>(sendMessage);
    on<GetScreenChatEvent>(sendNumber);
  }
  final supabase = SupabaseNetworking().getSupabase;

  String get getCurrentUserId => supabase.auth.currentUser!.id;

// GetUsersEvent :
  getUsers(GetUserChatEvent event, Emitter<ChatState> emit) async {
    try {
      final List allUsers =
          await supabase.from("users").select().eq("type", 'user');
      final List<UserModel> users =
          allUsers.map((user) => UserModel.fromJson(user)).toList();
      emit(GetUsersSuccessedState(users));
    } catch (e) {
      emit(ErrorGetUsersState());
    }
  }

  sendMessage(MessageEvent event, emit) async {
    try {
      await supabase.from("chats").insert({
        "contents": event.message,
        "id_from": getCurrentUserId,
        "id_to": event.idUserTo
      });
    } catch (e) {
      return;
    }
  }

  Stream getMessages(String toUserId) {
    // -- listen to stream from (messages) table ,
    //    and get messages just between (current user) and (selected user)
    final allMesages = supabase
        .from("chats")
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: true)
        .map((items) => items.where((element) =>
            element["id_from"] == getCurrentUserId &&
                element["id_to"] == toUserId ||
            element["id_from"] == toUserId &&
                element["id_to"] == getCurrentUserId));

// -- convert List<Map> to List<Message>
    final messages = allMesages.map((items) => items
        .map((item) => MessageModel.fromJson(item, getCurrentUserId))
        .toList());

    return messages;
  }

  FutureOr<void> sendNumber(GetScreenChatEvent event, Emitter<ChatState> emit) {
    emit(ScreenChatState(event.ind));
  }

  FutureOr<void> numberOfMessages(
      GetNumberOfMessagesEvent event, Emitter<ChatState> emit) async {
    try {
      final List allChats =
          await supabase.from("chats").select().eq("type", 'admin');
      List countChats = [];
      for (var element in allChats) {
        countChats.add(MessageModel.fromJson(element, getCurrentUserId));
      }
      final count = countChats.length; 

      print(count);
      emit(GetNumberOfMessagesState());
    } catch (e) {
      print(e);
    }
  }
}
