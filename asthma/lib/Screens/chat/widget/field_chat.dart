import 'package:asthma/blocs/chat_bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatField extends StatelessWidget {
  const ChatField({
    super.key,
    required this.controller,
    required this.toUserId,
  });

  final TextEditingController controller;
  final String toUserId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.grey[300]!),
      child: TextField(
        minLines: 1,
        maxLines: 4,
        controller: controller,
        decoration: InputDecoration(
            hintText: "send message",
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: IconButton(
              onPressed: () {
                context.read<ChatBloc>().add(MessageEvent(
                    message: controller.text.trim(), idUserTo: toUserId));
                controller.clear();
              },
              icon: const Icon(Icons.send),
            ),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
