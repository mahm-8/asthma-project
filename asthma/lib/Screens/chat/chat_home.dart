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
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is GetAdminSuccessedState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          user: state.admin.first,
                        )));
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
