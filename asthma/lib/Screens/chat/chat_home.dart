import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../blocs/chat_bloc/chat_bloc.dart';
import '../auth/login_screen.dart';
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
    context.read<ChatBloc>().add(GetUserChatEvent());
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
        actions: [
          IconButton(
              onPressed: () async {
                await Supabase.instance.client.auth.signOut();
                if (mounted) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is GetUsersSuccessedState) {
            return ListView.separated(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  user: state.users[index],
                                )));
                  },
                  child: ListTile(
                    title: Text(state.users[index].name ?? ""),
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
