import 'package:dashboard/bloc/chat_bloc/chat_bloc.dart';
import 'package:dashboard/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key, required this.user});
  final List<UserModel> user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(181, 175, 211, 226),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(181, 175, 211, 226),
          title: const Text('users')),
      body: ListView.separated(
        itemCount: user.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context.read<ChatBloc>().add(GetScreenChatEvent(index));
            },
            child: ListTile(
              title: Text(user[index].name ?? ""),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
