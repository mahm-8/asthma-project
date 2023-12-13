import 'package:dashboard/bloc/task_bloc.dart';
import 'package:dashboard/bloc/user_bloc/user_bloc.dart';
import 'package:dashboard/screens/dashboard/methods/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorInformation extends StatefulWidget {
  const DoctorInformation({
    super.key,
    required this.bloc,
    required this.taskController,
  });

  final UserBloc bloc;
  final TextEditingController taskController;

  @override
  State<DoctorInformation> createState() => _DoctorInformationState();
}

class _DoctorInformationState extends State<DoctorInformation> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(getTaskEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'lib/assets/Dashboard-bro.png',
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 20),
        Text(
          '${widget.bloc.user?.name}',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        Text(
          '${widget.bloc.user?.gender}',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        Text(
          '${widget.bloc.user?.email}',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Your Task Today',
        ),
        const SizedBox(height: 8),
        Container(
          height: 1,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 15),
        BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is getTaskState) {
              return SizedBox(
                width: 120,
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 50, 120, 152)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.done_outline_rounded,
                            size: 18,
                          ),
                          Text(state.tasks[index].task!),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        InkWell(
          onTap: () {
            ShowDialogWidget(context, widget.taskController);
          },
          child: Container(
            height: 30,
            width: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Color.fromARGB(255, 31, 59, 72),
                  size: 20,
                ),
                Text(
                  'Create New',
                  style: TextStyle(color: Color.fromARGB(255, 31, 59, 72)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
