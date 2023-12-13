import 'package:dashboard/screens/dashboard/widgets/char_bar_widget.dart';
import 'package:dashboard/screens/dashboard/widgets/drawer_widget.dart';
import 'package:dashboard/screens/dashboard/widgets/information_card_widgets.dart';
import 'package:dashboard/screens/dashboard/widgets/welcome_widget.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double _size = 250.0;
  bool _large = true;
  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 221, 221),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedSize(
              curve: Curves.easeIn,
              duration: const Duration(seconds: 1),
              child: LeftDrawer(size: _size)),
          Flexible(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      icon: const Icon(Icons.menu_open, color: Colors.black),
                      onPressed: () {
                        _updateSize();
                      }),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WelcomeWidget(),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Analysis Bar Chart ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Divider(),
                        SizedBox(
                          height: 25,
                        ),
                        CharBarWidget(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          InformationCard(),
        ],
      ),
    );
  }
}
