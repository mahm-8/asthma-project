// ignore_for_file: must_be_immutable
import 'package:dashboard/bloc/chat_bloc/chat_bloc.dart';
import 'package:dashboard/bloc/user_bloc/user_bloc.dart';
import 'package:dashboard/screens/dashboard/widgets/doctor_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationCard extends StatelessWidget {
  InformationCard({super.key});
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserBloc>();

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Color(0xff146C94),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return DoctorInformation(bloc: bloc, taskController: taskController);
        },
      ),
    );
  }
}
