import 'package:asthma/Screens/chat/widget/contain_mwssagw.dart';
import 'package:asthma/Screens/chat/widget/field_chat.dart';
import 'package:asthma/blocs/chat_bloc/chat_bloc.dart';
import 'package:asthma/helper/imports.dart';

import '../../Models/messageModel.dart';
import '../breathing/componnets/custom_appbar.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.user});
  final UserModel user;
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final chat = context.read<ChatBloc>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: customAppBar(context,
            title: user.name ?? "",
            showtitle: true,
            backcolor: Colors.transparent,
            iconColor: ColorPaltte().darkBlue),
        bottomSheet: ChatField(
          controller: messageController,
          toUserId: user.idAuth.toString(),
        ),
        body: StreamBuilder(
          stream: chat.getMessages(user.idAuth.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<MessageModel> messages = snapshot.data!;
              print(messages);
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
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
