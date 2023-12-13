import 'package:dashboard/bloc/auth_bloc/auth_bloc.dart';
import 'package:dashboard/screens/auth/login_screen.dart';
import 'package:dashboard/screens/chat/chat_web_screen.dart';
import 'package:dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:dashboard/screens/extensions/loading_extension.dart';
import 'package:dashboard/screens/extensions/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: size,
        color: Color(0xff146C94),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              color: Color(0xff146C94),
              child: Text('Dashboard'),
            ),
            Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(top: 30),
                child: const Text('THEME',
                    style: TextStyle(
                      color: Colors.grey,
                    ))),
            _tile(
                label: 'Home',
                onTap: () => context.push(view: const DashboardScreen())),
            _tile(
                label: 'Chat',
                onTap: () => context.push(view: ChatWebScreen())),
            BlocListener<AuthBloc, AuthStates>(
              listener: (context, state) {
                if (state is LogoutSuccessState) {
                  context.pushAndRemoveUntil(view: LoginScreen());
                }
              },
              child: _tile(
                  label: 'Logout',
                  onTap: () {
                    context.showLoading();
                    context.read<AuthBloc>().add(LogoutEvent());
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile({required String label, Function()? onTap}) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }
}
