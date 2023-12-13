import 'package:asthma/Screens/breathing/componnets/custom_appbar.dart';
import 'package:asthma/helper/imports.dart';

Widget? barcode;
String? imageUrl;

class SymptomTrackerScreen extends StatefulWidget {
  const SymptomTrackerScreen({super.key});

  @override
  SymptomTrackerScreenState createState() => SymptomTrackerScreenState();
}

class SymptomTrackerScreenState extends State<SymptomTrackerScreen> {
  @override
  void initState() {
    context.read<AsthmaBloc>().add(GetSymptomDataEvent());
    super.initState();
  }

  String selectedSymptom = 'cough';
  String selectedLevel = 'Low';
  TextEditingController symptomsDescriptionsController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
          context,
          hasAction: true,
          backcolor: ColorPaltte().newDarkBlue,
          iconColor: ColorPaltte().white,
        ),
        body: Stack(
          children: [
            Container(
              width: context.getWidth(),
              decoration: BoxDecoration(
                  color: ColorPaltte().newDarkBlue,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              height: 300,
            ),
            Positioned(
              top: -100,
              right: 50,
              child: Image.asset(
                'lib/assets/images/Doctor-bro.png',
                width: 500,
                height: 500,
              ),
            ),
            Positioned(
              left: 175,
              top: 120,
              child: Text(
                "Symptoms",
                style: TextStyle(
                    fontSize: 35,
                    color: ColorPaltte().white,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 320,
                    ),
                    Row(
                      children: [
                        Text(
                          'Your symptoms',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: ColorPaltte().darkBlue),
                        ),
                        const Spacer(),
                        // SymptomBottomSheetButton(context: context),
                        TextButton(
                          onPressed: () async {
                            await showButtonSheet(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: ColorPaltte().newDarkBlue,
                              ),
                              Text(
                                'Add Symptom',
                                style: TextStyle(
                                  color: ColorPaltte().newDarkBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<AsthmaBloc, AsthmaState>(
                      buildWhen: (oldState, newState) {
                        if (newState is SuccessGetSymptomState) {
                          return true;
                        }
                        if (newState is LoadingState) {
                          return true;
                        }
                        return false;
                      },
                      builder: (context, state) {
                        if (state is SuccessGetSymptomState) {
                          if (state.symptoms.isNotEmpty) {
                            return Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.symptoms.length,
                                itemBuilder: (context, index) {
                                  final symptom = state.symptoms[index];
                                  return DataCardWidget(
                                    textEntry1:
                                        "Symptom: ${symptom.symptomName}",
                                    textEntry2:
                                        "Details: ${symptom.symptomDetails}",
                                    textEntry3:
                                        "intensity: ${symptom.symptomIntensity}",
                                    deleteTap: () {
                                      context.read<AsthmaBloc>().add(
                                          DeleteSymptomEvent(
                                              id: symptom.symptomID!));
                                    },
                                    imageURL: 'lib/assets/images/symptoms.png',
                                  );
                                },
                              ),
                            );
                          } else {
                            return Center(
                              child: Text(
                                "No symptoms added",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorPaltte().darkBlue),
                              ),
                            );
                          }
                        } else if (state is ErrorGetState) {
                          const Center(child: Text("Error getting data"));
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)));
                          Future.delayed(Duration(seconds: 1), () {});
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Future<dynamic> showButtonSheet(BuildContext context) {
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
        return Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.65),
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
                  "Symptom",
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
                    hint: const Text('Select Symptom'),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: [
                      'cough',
                      'shortness of breath',
                      'Disordered sleep',
                    ].map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSymptom = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Symptom Intensity",
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
                    items: ['Low', 'Moderate', 'High'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedLevel = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                AddTextfield(
                  label: 'Details',
                  fieldController: symptomsDescriptionsController,
                  fieldWidth: MediaQuery.of(context).size.width * 0.95,
                  fieldHeight: 135,
                  onlyRead: false,
                  title: 'Details',
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
                      selectedSymptom = 'cough';
                      selectedLevel = 'Low';
                    } else if (state is ADDErrorState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  child: ButtonWidget(
                    widget: Text(
                      "Add",
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
                        'cancel',
                        style: const TextStyle().darkblue700,
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
