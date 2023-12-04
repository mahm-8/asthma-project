import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/text.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: ColorPaltte().lightBlue,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const TabBarView(
                    children: <Widget>[
                      Center(
                        child: Text("It's cloudy here"),
                      ),
                      Center(
                        child: Text("It's rainy here"),
                      ),
                      Center(
                        child: Text("It's sunny here"),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              left: 20,
              top: 200,
              child: Container(
                padding: const EdgeInsets.only(top: 60),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorPaltte().lightgreentr),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    Text(
                      "John Doe",
                      style: const TextStyle().blod20,
                    ),
                    const Text(
                      "ID:0512345678",
                    ),
                    const Divider(),
                    const TabBar(dividerColor: Colors.transparent, tabs: [
                      Tab(
                        child: Text(
                          "Personal info",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Tab(
                        icon: Icon(Icons.beach_access_sharp),
                      ),
                      Tab(
                        child: Text(
                          "Tools",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ),
            Positioned(
              left: 145,
              top: 150,
              child: ClipOval(
                child: Container(
                  color: ColorPaltte().darkGreen,
                  height: 100,
                  width: 100,
                  child: Icon(Icons.person_outline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
