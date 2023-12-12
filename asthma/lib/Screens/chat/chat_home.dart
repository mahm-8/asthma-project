import '../../blocs/chat_bloc/chat_bloc.dart';
import 'package:asthma/helper/imports.dart';
import 'chat_screen.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    context.read<ChatBloc>().add(GetAdminChatEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Users",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is GetAdminSuccessedState) {
            return ListView.separated(
              itemCount: state.admin.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  user: state.admin[index],
                                )));
                  },
                  child: ListTile(
                    title: Text(state.admin[index].name ?? ""),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
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
