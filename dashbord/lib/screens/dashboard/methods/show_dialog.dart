
  import 'package:dashboard/bloc/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> ShowDialogWidget(BuildContext context,TextEditingController task) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width / 4,
          child: SizedBox(
            height: 10,
            child: TextField(
              controller: task,
              decoration: InputDecoration(
                hintText: 'Write task',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.grey)),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context
                  .read<TaskBloc>()
                  .add(AddTaskEvent(task: task.text));
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

