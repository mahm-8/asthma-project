import 'package:asthma/helper/imports.dart';
import 'package:intl/intl.dart';

TextEditingController medicationNameController = TextEditingController(),
    medicationQuantitysController = TextEditingController(),
    medicationDateController = TextEditingController(),
    medicationDaysController = TextEditingController();
Future<dynamic> showButtonSheet(BuildContext context) {
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
                label: 'Medication Name',
                fieldController: medicationNameController,
                fieldWidth: MediaQuery.of(context).size.width * 0.95,
                onlyRead: false,
                title: 'Medication Name',
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AddTextfield(
                    label: 'Quantity in day',
                    fieldController: medicationQuantitysController,
                    fieldWidth: MediaQuery.of(context).size.width * 0.44,
                    onlyRead: false,
                    title: 'Quantity in day',
                  ),
                  AddTextfield(
                    label: 'No. of Days to take',
                    fieldController: medicationDaysController,
                    fieldWidth: MediaQuery.of(context).size.width * 0.44,
                    onlyRead: false,
                    title: 'Days',
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
                label: 'Start Date',
                fieldController: medicationDateController,
                fieldWidth: MediaQuery.of(context).size.width,
                onlyRead: true,
                title: 'Start Date',
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
                  widget: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
                    'cancel',
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
