import 'package:asthma/helper/imports.dart';

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
          backgroundColor: ColorPaltte().newDarkBlue,
          elevation: 0,
          title: Text(AppLocalizations.of(context)!.edit_profile),
          centerTitle: true,
        ),
        body: SafeArea(
            child: ListView(
          children: [
            EditTextField(
              label: AppLocalizations.of(context)!.name,
              hint: "Username",
              controller: nameController,
            ),
            EditTextField(
              label: AppLocalizations.of(context)!.phone,
              hint: "05xxxxxxxx",
              controller: phoneController,
            ),
            EditTextField(
              label: AppLocalizations.of(context)!.age,
              hint: "age",
              controller: ageController,
            ),
            EditTextField(
              label: AppLocalizations.of(context)!.birthday,
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
              label: AppLocalizations.of(context)!.gender,
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
                  text: AppLocalizations.of(context)!.update,
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
