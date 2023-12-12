// ignore_for_file: must_be_immutable

import 'package:asthma/helper/imports.dart';

class SettingWidget extends StatelessWidget {
  SettingWidget({super.key, required this.bloc});
  var lan = true;
  final UserBloc bloc;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 50, bottom: 16, right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 400,
              height: 200,
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UploadImageCaptureState) {
                    return Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 71, 34, 159),
                                width: 1.5),
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: state.barcode));
                  }
                  return Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 71, 34, 159),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child:
                              generateBarcode(bloc.user!.imageCapture ?? "")));
                },
              ),
            ),
            const Spacer(),
            BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                if (state is SwitchState) {

                  return ListTile(
                    title: Text(AppLocalizations.of(context)!.language),
                    trailing: Switch(
                        value: state.swit,

                        onChanged: (value) {
                          context
                              .read<LanguageBloc>()
                              .add(ChangeLanguage(value));
                        }),

                  );
                }
                return ListTile(
                  title: Text(AppLocalizations.of(context)!.language),
                  trailing: Switch(
                      value: lan,
                      onChanged: (value) {
                        context.read<LanguageBloc>().add(ChangeLanguage(value));
                      }),

                );
              },
            ),
            BlocListener<AuthBloc, AuthStates>(
              listener: (context, state) {
                if (state is LogoutSuccessState) {
                  context.pushAndRemoveUntil(view: LoginScreen());
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
                title: AppLocalizations.of(context)!.logout,
                colorText: Colors.red,
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                  showDialog(
                      context: context,
                      builder: (context) => const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
