import 'package:asthma/helper/imports.dart';
import 'package:intl/intl.dart';

TextEditingController medicationNameController = TextEditingController(),
    medicationQuantitysController = TextEditingController(),
    medicationDateController = TextEditingController(),
    medicationDaysController = TextEditingController();
Future<dynamic> showMedicationButtonSheet(BuildContext context) {
  return showModalBottomSheet(
    showDragHandle: true,
    useSafeArea: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Container(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.65),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              AddTextfield(
                label: AppLocalizations.of(context)!.medcName,
                fieldController: medicationNameController,
                fieldWidth: MediaQuery.of(context).size.width * 0.95,
                onlyRead: false,
                title: AppLocalizations.of(context)!.medcName,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AddTextfield(
                    label: AppLocalizations.of(context)!.quantityDay,
                    fieldController: medicationQuantitysController,
                    fieldWidth: MediaQuery.of(context).size.width * 0.44,
                    onlyRead: false,
                    title: AppLocalizations.of(context)!.quantityDay,
                  ),
                  AddTextfield(
                    label: AppLocalizations.of(context)!.daysToTake,
                    fieldController: medicationDaysController,
                    fieldWidth: MediaQuery.of(context).size.width * 0.44,
                    onlyRead: false,
                    title: AppLocalizations.of(context)!.day,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              AddTextfield(
                onTapped: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2024));

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);

                    medicationDateController.text = formattedDate;
                  }
                },
                icon: Icon(
                  Icons.date_range,
                  color: ColorPaltte().newDarkBlue,
                ),
                label: AppLocalizations.of(context)!.startDateCap,
                fieldController: medicationDateController,
                fieldWidth: MediaQuery.of(context).size.width,
                onlyRead: true,
                title: AppLocalizations.of(context)!.startDateCap,
              ),
              const SizedBox(
                height: 16,
              ),
              BlocListener<AsthmaBloc, AsthmaState>(
                listener: (context, state) {
                  if (state is SucsessMessageState) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text(state.message),
                            ));
                    medicationNameController.clear();
                    medicationDaysController.clear();
                    medicationDateController.clear();
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
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPress: () {
                    context.read<AsthmaBloc>().add(AddMedicationEvent(
                        medicationNameController.text,
                        int.parse(medicationDaysController.text),
                        medicationDateController.text));
                    Navigator.pop(context);
                  },
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: TextStyle(
                        color: ColorPaltte().darkBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ))
            ],
          ),
        ),
      );
    },
  );
}
