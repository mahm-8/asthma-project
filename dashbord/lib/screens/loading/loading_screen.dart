import 'package:dashboard/bloc/auth_bloc/auth_bloc.dart';
import 'package:dashboard/bloc/user_bloc/user_bloc.dart';
import 'package:dashboard/screens/auth/login_screen.dart';
import 'package:dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthStates>(
      buildWhen: (oldState, newState) {
        if (newState is CheckLoginState) {
          context.read<UserBloc>().add(LoadUserDataEvent());
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) =>  const DashboardScreen()),
                (route) => false);
          });
        } else if (newState is ErrorCheckState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false);
        }
        return false;
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  }

}

