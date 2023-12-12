import 'package:asthma/Models/messageModel.dart';
import 'package:asthma/helper/imports.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<GetUserChatEvent>(getUsers);
    on<GetAdminChatEvent>(getAdmin);
    on<MessageEvent>(sendMessage);
    on<GetScreenChatEvent>(sendNumber);
  }
  final supabase = Supabase.instance.client;

  String get getCurrentUserId => supabase.auth.currentUser!.id;

// GetUsersEvent :
  getUsers(GetUserChatEvent event, Emitter<ChatState> emit) async {
    try {
      final List allUsers =
          await supabase.from("users").select().eq("type", 'user');
      final List<UserModel> users =
          allUsers.map((user) => UserModel.fromJson(user)).toList();
      print(users.length);
      emit(GetUsersSuccessedState(users));
    } catch (e) {
      print(e);
      emit(ErrorGetUsersState());
    }
  }

  getAdmin(GetAdminChatEvent event, Emitter<ChatState> emit) async {
    try {
      final List data =
          await supabase.from("users").select().match({"type": "admin"});
      print(data);
      print("hhhhhh");
      final List<UserModel> users =
          data.map((user) => UserModel.fromJson(user)).toList();
      print(users);
      emit(GetAdminSuccessedState(admin: users));
    } catch (e) {
      return;
    }
  }

  sendMessage(MessageEvent event, emit) async {
    try {
      final MessageModel message = MessageModel(
          contents: event.message,
          idFrom: getCurrentUserId,
          idTo: event.idUserTo);
      print("########################");
      print(getCurrentUserId);
      print(event.idUserTo);
      await supabase.from("chats").insert({
        "contents": event.message,
        "id_from": getCurrentUserId,
        "id_to": event.idUserTo
      });
      print("*****************");
    } catch (e) {
      print(e);
    }
  }

  Stream getMessages(String toUserId) {
    // -- listen to stream from (messages) table ,
    //    and get messages just between (current user) and (selected user)
    final allMesaages = supabase
        .from("chats")
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

  FutureOr<void> sendNumber(GetScreenChatEvent event, Emitter<ChatState> emit) {
    emit(ScreenChatState(event.ind));
  }
}
