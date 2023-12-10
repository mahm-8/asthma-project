import 'package:asthma/Models/user_model.dart';
import 'package:asthma/Screens/auth/widgets/button_auth_widget.dart';
import 'package:asthma/Screens/profile/method/date_time_widget.dart';
import 'package:asthma/Screens/profile/widget/edit_text_field.dart';
import 'package:asthma/blocs/user_bloc/user_bloc.dart';
import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatelessWidget {
  const EditProfile(
      {super.key,
      required this.phoneController,
      required this.nameController,
      required this.ageController,
      required this.birthdayController,
      required this.genderController});
  final TextEditingController phoneController;
  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController birthdayController;
  final TextEditingController genderController;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPaltte().darkBlue,
          elevation: 0,
          title: Text("Edit Profile"),
          centerTitle: true,
        ),
        body: SafeArea(
            child: ListView(
          children: [
            EditTextField(
              label: "name",
              hint: "Username",
              controller: nameController,
            ),
            EditTextField(
              label: "phone",
              hint: "05xxxxxxxx",
              controller: phoneController,
            ),
            EditTextField(
              label: "age",
              hint: "age",
              controller: ageController,
            ),
            EditTextField(
              label: "birthday",
              hint: "1900/12/31",
              keyboardType: TextInputType.datetime,
              controller: birthdayController,
              isFelid: false,
              onTap: () => showDatePickerWidget(
                context: context,
                onDateTimeChanged: (date) {
                  birthdayController.text = date;
                },
              ),
            ),
            EditTextField(
              label: "gender",
              hint: "male/female",
              controller: genderController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is SuccessUpdateState) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } else if (state is ErrorUpdateState) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text(state.msg),
                            ));
                  }
                },
                child: ButtonAuthWidget(
                  text: "Update",
                  onPressed: () {
                    final user = UserModel(
                        name: nameController.text.trim(),
                        dob: birthdayController.text.trim(),
                        phone: phoneController.text.trim(),
                        age: ageController.text.trim(),
                        gender: genderController.text.trim());
                    context.read<UserBloc>().add(UpdateUserEvent(user: user));
                    showDialog(
                      context: context,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
