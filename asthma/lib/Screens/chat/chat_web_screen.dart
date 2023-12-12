import '../../blocs/chat_bloc/chat_bloc.dart';
import '../../helper/imports.dart';
import 'chat_web_widget.dart';

class ChatWebScreen extends StatelessWidget {
  ChatWebScreen({super.key});

  List<UserModel>? model;
  UserModel? nullModel;

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(GetUserChatEvent());
    return Scaffold(
      body: BlocBuilder<ChatBloc, ChatState>(
        buildWhen: (oldState, newState) {
          if (newState is GetUsersSuccessedState) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is GetUsersSuccessedState) {
            model = state.users;
            ;
            return Row(
              children: [
                SizedBox(
                  width: 200,
                  child: ListView.separated(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context
                              .read<ChatBloc>()
                              .add(GetScreenChatEvent(index));
                        },
                        child: ListTile(
                          title: Text(state.users[index].name ?? ""),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
                ),
                BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ScreenChatState) {
                      return SizedBox(
                          width: 300,
                          child: ChatWebWidget(user: model![state.num]));
                    }
                    return Expanded(child: ChatWebWidget(user: model![0]));
                  },
                )
              ],
            );
          } else if (state is ErrorGetUsersState) {
            return const Text("U don't have friend");
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
