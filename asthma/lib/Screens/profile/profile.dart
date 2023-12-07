import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
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
        backgroundColor: ColorPaltte().newDarkBlue,
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
                  child: TabBarView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            SizedBox(height: context.getHeight(divide: 6)),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              color: ColorPaltte().white,
                              child: ListTile(
                                title: Text(
                                  "Phone",
                                  style: TextStyle(
                                      color: ColorPaltte().darkBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  "05123456789",
                                  style: TextStyle(
                                    color: ColorPaltte().darkBlue,
                                  ),
                                ),
                                leading: const Icon(Icons.phone),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Card(
                              color: ColorPaltte().white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              child: ListTile(
                                title: Text(
                                  "city",
                                  style: TextStyle(
                                      color: ColorPaltte().darkBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text("riyadh",
                                    style: TextStyle(
                                      color: ColorPaltte().darkBlue,
                                    )),
                                leading: const Icon(Icons.location_on),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Card(
                              color: ColorPaltte().white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              child: ListTile(
                                title: Text(
                                  "birthday",
                                  style: TextStyle(
                                      color: ColorPaltte().darkBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  "1995-07-07",
                                  style: TextStyle(
                                      color: ColorPaltte().darkBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                leading: const Icon(Icons.calendar_month),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Center(
                        child: Text("It's rainy here"),
                      ),
                      const Center(
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
                    color: ColorPaltte().newlightBlue),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    Text(
                      "John Doe",
                      style: const TextStyle().bold24,
                    ),
                    const Text(
                      "ID:0512345678",
                    ),
                    const Divider(),
                    TabBar(dividerColor: Colors.transparent, tabs: [
                      Tab(
                        child: Text(
                          "Personal info",
                          style: TextStyle(color: ColorPaltte().darkBlue),
                        ),
                      ),
                      const Tab(
                        icon: Icon(Icons.beach_access_sharp),
                      ),
                      Tab(
                        child: Text(
                          "Tools",
                          style: TextStyle(color: ColorPaltte().darkBlue),
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
                  color: ColorPaltte().newBlue,
                  height: 100,
                  width: 100,
                  child: const Icon(Icons.person_outline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
