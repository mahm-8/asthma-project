import '../../../helper/imports.dart';

TextEditingController symptomsDescriptionsController = TextEditingController();

Future<dynamic> showSymptomButtonSheet(BuildContext context) {
  String selectedSymptom = AppLocalizations.of(context)!.cough;
  String selectedLevel = AppLocalizations.of(context)!.low;
  return showModalBottomSheet(
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<AsthmaBloc, AsthmaState>(
        builder: (context, state) {
          if (state is ChangeSymptomState) {
            selectedSymptom = state.selectedSymptom;
          }
          if (state is ChangeLevelState) {
            selectedLevel = state.selectedLevel;
          }
          return Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!.symptom,
                    style: const TextStyle().fieldFont,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: ColorPaltte().fieldGrey,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButton(
                      iconDisabledColor: ColorPaltte().darkBlue,
                      iconEnabledColor: ColorPaltte().darkBlue,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(20),
                      value: selectedSymptom,
                      hint: Text(AppLocalizations.of(context)!.addSymptom),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: [
                        AppLocalizations.of(context)!.cough,
                        AppLocalizations.of(context)!.breathShort,
                        AppLocalizations.of(context)!.disorderSleep,
                      ].map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        context
                            .read<AsthmaBloc>()
                            .add(ChooseSymptomEvent(value!));
                        // setState(() {
                        //   selectedSymptom = value!;
                        // });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.symIntensity,
                    style: const TextStyle().fieldFont,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                        color: ColorPaltte().fieldGrey,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButton(
                      iconDisabledColor: ColorPaltte().darkBlue,
                      iconEnabledColor: ColorPaltte().darkBlue,
                      borderRadius: BorderRadius.circular(20),
                      value: selectedLevel,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: [
                        AppLocalizations.of(context)!.low,
                        AppLocalizations.of(context)!.moderate,
                        AppLocalizations.of(context)!.high
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        context
                            .read<AsthmaBloc>()
                            .add(ChooseLevelEvent(value!));
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  AddTextfield(
                    label: AppLocalizations.of(context)!.details,
                    fieldController: symptomsDescriptionsController,
                    fieldWidth: MediaQuery.of(context).size.width * 0.95,
                    fieldHeight: 135,
                    onlyRead: false,
                    title: AppLocalizations.of(context)!.details,
                  ),
                  const SizedBox(height: 16),
                  BlocListener<AsthmaBloc, AsthmaState>(
                    listener: (context, state) {
                      if (state is SucsessMessageState) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text(state.message),
                                ));
                        symptomsDescriptionsController.clear();
                        selectedSymptom = AppLocalizations.of(context)!.cough;
                        selectedLevel = AppLocalizations.of(context)!.low;

                        Navigator.pop(context);
                      } else if (state is ADDErrorState) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text(state.message),
                                ));
                      }
                    },
                    child: ButtonWidget(
                      widget: Text(
                        AppLocalizations.of(context)!.add,
                        style: const TextStyle().fontwhite,
                      ),
                      onPress: () {
                        context.read<AsthmaBloc>().add(AddSymptomEvent(
                            selectedSymptom,
                            symptomsDescriptionsController.text,
                            selectedLevel));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: const TextStyle().darkblue700,
                        )),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
