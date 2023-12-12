import 'package:asthma/Screens/chat/widget/contain_mwssagw.dart';
import 'package:asthma/Screens/chat/widget/field_chat.dart';
import 'package:asthma/blocs/chat_bloc/chat_bloc.dart';
import 'package:asthma/helper/imports.dart';

import '../../Models/messageModel.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.user});
  final UserModel user;
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name ?? ""),
      ),
      bottomSheet: ChatField(
        controller: messageController,
        toUserId: user.id.toString(),
      ),
      body: StreamBuilder(
        stream: bloc.getMessages(user.id.toString()),
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
