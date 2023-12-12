import 'package:dashboard/bloc/chat_bloc/chat_bloc.dart';
import 'package:dashboard/model/message_model.dart';
import 'package:dashboard/model/user_model.dart';
import 'package:dashboard/screens/chat/widget/contain_mwssagw.dart';
import 'package:dashboard/screens/chat/widget/field_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatWebWidget extends StatelessWidget {
  ChatWebWidget({super.key, required this.user});
  final UserModel user;
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final chat = context.read<ChatBloc>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(user.name ?? ""),
        backgroundColor: const Color.fromARGB(181, 175, 211, 226),
      ),
      bottomSheet: ChatField(
        controller: messageController,
        toUserId: user.idAuth.toString(),
      ),
      body: StreamBuilder(
        stream: chat.getMessages(user.idAuth.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<MessageModel> messages = snapshot.data!;
            ScrollController scrollController = ScrollController();

            Future.delayed(const Duration(milliseconds: 100 ~/ 60), () {
              scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear);
            });

            return ListView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                shrinkWrap: true,
                controller: scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ContainMessage(
                      message: messages[index].contents ?? "",
                      isMine: messages[index].isMain ?? true);
                });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
