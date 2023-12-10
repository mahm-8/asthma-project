// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:asthma/Screens/auth/login_screen.dart';
import 'package:asthma/Screens/profile/edit_profile.dart';
import 'package:asthma/Screens/profile/widget/info.dart';

import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/loading_extension.dart';
import 'package:asthma/extensions/navigator.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
import 'package:asthma/extensions/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import 'widget/tools_widget.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final ImagePicker picker = ImagePicker();
  TextEditingController? phoneController = TextEditingController();
  TextEditingController? nameController = TextEditingController();
  TextEditingController? ageController = TextEditingController();
  TextEditingController? birthdayController = TextEditingController();
  TextEditingController? genderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserBloc>();
    getControllerValue(context: context);
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            InkWell(
                onTap: () {
                  context.push(
                      view: EditProfile(
                          phoneController: phoneController!,
                          nameController: nameController!,
                          ageController: ageController!,
                          birthdayController: birthdayController!,
                          genderController: genderController!));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    'assets/edit_profile.png',
                    color: ColorPaltte().white,
                    height: 30,
                    width: 30,
                  ),
                )),
          ],
        ),
        backgroundColor: ColorPaltte().newDarkBlue,
        body: BlocBuilder<UserBloc, UserState>(
          buildWhen: (oldState, newState) {
            if (newState is LoadState) {
              return true;
            }
            return false;
          },
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
                            CardInfo(
                                phone: bloc.user!.phone!,
                                birthday: bloc.user!.dob!,
                                email: bloc.user!.email!,
                                age: bloc.user!.age!,
                                gender: bloc.user!.gender!),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 16),
                              child: Column(
                                children: [
                                  const Spacer(),
                                  BlocListener<AuthBloc, AuthState>(
                                    listener: (context, state) {
                                      if (state is LogoutSuccessState) {
                                        context.pushAndRemoveUntil(
                                            view: LoginScreen());
                                      } else if (state is ErrorLogoutState) {
                                        Navigator.of(context).pop();
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: const Text("Error"),
                                                  content: Text(state.msg),
                                                ));
                                      }
                                    },
                                    child: ToolsWidget(
                                      title: 'Logout',
                                      colorText: Colors.red,
                                      onPressed: () {
                                        context
                                            .read<AuthBloc>()
                                            .add(LogoutEvent());
                                        showDialog(
                                            context: context,
                                            builder: (context) => const Center(
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive(),
                                                ));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    left: context.getWidth(divide: 20),
                    top: context.getHeight(divide: 10),
                    child: Container(
                      padding: const EdgeInsets.only(top: 60),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorPaltte().conlightBlue),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        children: [
                          Text(
                            bloc.user!.name!,
                            style: const TextStyle().bold24,
                          ),
                          Text(bloc.user!.id!.toString()),
                          const Divider(),
                          TabBar(
                              indicatorColor: ColorPaltte().darkBlue,
                              indicatorPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              tabs: [
                                Tab(
                                  child: Text(
                                    "Personal info",
                                    style: TextStyle(
                                        color: ColorPaltte().darkBlue),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Tools",
                                    style: TextStyle(
                                        color: ColorPaltte().darkBlue),
                                  ),
                                ),
                              ])
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: context.getWidth(divide: 2.7),
                    top: context.getHeight(divide: 25),
                    child: ClipOval(
                      child: BlocConsumer<UserBloc, UserState>(
                        listener: (context, state) {
                          if (state is ErrorUploadState) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(state.msg),
                                  );
                                });
                          }
                          if (state is UploadImageState) {
                            Navigator.of(context).pop();
                          }
                        },
                        builder: (context, state) {
                          if (state is UploadImageState) {
                            return Container(
                                color: ColorPaltte().newBlue,
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  state.url,
                                  fit: BoxFit.cover,
                                ));
                          }
                          return Container(
                            color: ColorPaltte().newBlue,
                            height: 100,
                            width: 100,
                            child: bloc.user!.image != null
                                ? Image.network(
                                    bloc.user!.image!,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.person_outline),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                      left: context.getWidth(divide: 1.75),
                      top: context.getHeight(divide: 8),
                      child: ClipOval(
                        child: InkWell(
                          onTap: () async {
                            XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);

                            final imageFile = await image!.readAsBytes();

                            context
                                .read<UserBloc>()
                                .add(UploadeImageEvent(imageFile));
                            context.showLoading();
                          },
                          child: Container(
                              padding: EdgeInsets.all(4),
                              color: ColorPaltte().lightBlue,
                              child: Icon(
                                Icons.mode_edit_outlined,
                                size: 20,
                                color: ColorPaltte().newDarkBlue,
                              )),
                        ),
                      ))
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

  getControllerValue({required BuildContext context}) {
    final bloc = context.read<UserBloc>();
    nameController!.text = bloc.user!.name ?? "";
    phoneController!.text = bloc.user!.phone ?? "";
    ageController!.text = bloc.user!.age ?? "";
    birthdayController!.text = bloc.user!.dob ?? "";
    genderController!.text = bloc.user!.gender ?? "";
  }
}
