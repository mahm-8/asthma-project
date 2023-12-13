// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:asthma/helper/imports.dart';

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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is LoadState) {
                            return CardInfo(
                                phone: bloc.user?.phone??"",
                                birthday: bloc.user?.dob??"",
                                email: bloc.user?.email??"",
                                age: bloc.user?.age??"",
                                gender: bloc.user?.gender??"");
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      SettingWidget(
                        bloc: bloc,
                      )
                    ],
                  ),
                )
              ],
            ),
            TapWidget(
              bloc: bloc,
            ),
            ContainerImage(
              bloc: bloc,
            ),
            Positioned(
              left: context.getWidth(divide: 1.75),
              top: context.getHeight(divide: 8),
              child: ClipOval(
                  child: InkWell(
                onTap: () async {
                  XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);

                  final imageFile = await image!.readAsBytes();
                  if (imageFile.isNotEmpty) {
                    context.read<UserBloc>().add(UploadImageEvent(imageFile));
                    context.showLoading();
                  }
                },
                child: Container(
                    padding: const EdgeInsets.all(4),
                    color: ColorPaltte().lightBlue,
                    child: Icon(
                      Icons.mode_edit_outlined,
                      size: 20,
                      color: ColorPaltte().newDarkBlue,
                    )),
              )),
            ),
          ],
        ),
      ),
    );
  }

  getControllerValue({required BuildContext context}) {
    final bloc = context.read<UserBloc>();
    nameController?.text = bloc.user?.name ?? "";
    phoneController?.text = bloc.user?.phone ?? "";
    ageController?.text = bloc.user?.age ?? "";
    birthdayController?.text = bloc.user?.dob ?? "";
    genderController?.text = bloc.user?.gender ?? "";
  }
}
