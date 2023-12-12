import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({
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
                child: Text('THEME',
                    style: TextStyle(
                      color: Colors.grey,
                    ))),
            _tile('Home'),
            _tile('Chat'),
            _tile('Logout'),
          ],
        ),
      ),
    );
  }

  Widget _tile(String label) {
    return ListTile(
      title: Text(label),
      onTap: () {},
    );
  }
}
