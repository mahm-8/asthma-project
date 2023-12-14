// ignore_for_file: must_be_immutable

import 'package:dashboard/bloc/chat_bloc/chat_bloc.dart';
import 'package:dashboard/model/user_model.dart';
import 'package:dashboard/screens/chat/widget/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_web_widget.dart';

class ChatWebScreen extends StatelessWidget {
  ChatWebScreen({super.key});

  List<UserModel>? model;

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
            return Row(
              children: [
                SizedBox(
                  width: 200,
                  child: UserWidget(
                    user: state.users,
                  ),
                ),
                BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ScreenChatState) {
                      return Expanded(
                          child: ChatWebWidget(user: model![state.num]));
                    }
                    return Expanded(child: ChatWebWidget(user: model![0]));
                  },
                )
              ],
            );
          } else if (state is ErrorGetUsersState) {
            return const Text("no messages from users");
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
