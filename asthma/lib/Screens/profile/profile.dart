import 'dart:io';

import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
import 'package:asthma/extensions/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../blocs/user_bloc/user_bloc.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final ImagePicker picker = ImagePicker();
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserBloc>();
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: ColorPaltte().newDarkBlue,
        body: BlocBuilder<UserBloc, UserState>(
          // buildWhen: (oldState, newState) {
          //   if (newState is LoadState) {
          //     return true;
          //   }
          //   return false;
          // },
          builder: (context, state) {
            if (state is LoadState) {
              return Stack(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: context.getHeight(divide: 6)),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
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
                                        bloc.user!.phone!,
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
                                        borderRadius:
                                            BorderRadius.circular(16)),
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
                                        borderRadius:
                                            BorderRadius.circular(16)),
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
                            bloc.user!.name!,
                            style: const TextStyle().bold24,
                          ),
                          Text(bloc.user!.id!.toString()),
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
                      child: InkWell(
                        onTap: () async {
                          XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          imageFile = File(image!.path);
                          print(imageFile);
                        },
                        child: Container(
                          color: ColorPaltte().newBlue,
                          height: 100,
                          width: 100,
                          child: imageFile != null
                              ? Image.file(imageFile!)
                              : const Icon(Icons.person_outline),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
