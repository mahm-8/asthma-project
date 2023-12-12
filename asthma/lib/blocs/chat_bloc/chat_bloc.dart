import 'dart:async';

import 'package:asthma/Models/messageModel.dart';
import 'package:asthma/helper/imports.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<GetUserChatEvent>(getUsers);
    on<MessageEvent>(sendMessage);
  }
  final supabase = Supabase.instance.client;

  String get getCurrentUserId => supabase.auth.currentUser!.id;

// GetUsersEvent :
  getUsers(GetUserChatEvent event, Emitter<ChatState> emit) async {
    try {
      final List allUsers = await supabase
          .from("users")
          .select()
          .neq("id_auth", supabase.auth.currentUser!.id);

      print(allUsers);
      final List<UserModel> users =
          allUsers.map((user) => UserModel.fromJson(user)).toList();
      emit(GetUsersSuccessedState(users));
    } catch (e) {
      print(e);
      emit(ErrorGetUsersState());
    }
  }

// SendMessageEvent :
  sendMessage(MessageEvent event, emit) async {
    try {
      final MessageModel message = MessageModel(
          contents: event.message,
          idFrom: getCurrentUserId,
          idTo: event.idUserTo);
      await supabase.from("messages").insert(message.toJson());
    } catch (e) {
      print(e);
    }
  }

  Stream getMessages(String toUserId) {
    // -- listen to stream from (messages) table ,
    //    and get messages just between (current user) and (selected user)
    final allMesaages = supabase
        .from("messages")
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: true)
        .map((items) => items.where((element) =>
            element["id_from"] == getCurrentUserId &&
                element["id_to"] == toUserId ||
            element["id_from"] == toUserId &&
                element["id_to"] == getCurrentUserId));

// -- convert List<Map> to List<Message>
    final messages = allMesaages.map((items) => items
        .map((item) => MessageModel.fromJson(item, getCurrentUserId))
        .toList());

    return messages;
  }
}
