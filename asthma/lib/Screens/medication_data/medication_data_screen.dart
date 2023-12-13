// ignore_for_file: library_private_types_in_public_api
import 'package:asthma/Screens/medication_data/component/medication_bottomsheet.dart';

import '../../helper/imports.dart';
import '../breathing/componnets/custom_appbar.dart';

class MedicationTrackerScreen extends StatefulWidget {
  const MedicationTrackerScreen({super.key});

  @override
  _MedicationTrackerScreenState createState() =>
      _MedicationTrackerScreenState();
}

class _MedicationTrackerScreenState extends State<MedicationTrackerScreen> {
  @override
  void initState() {
    context.read<AsthmaBloc>().add(GetMedicationDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context,
          backcolor: ColorPaltte().newDarkBlue, iconColor: ColorPaltte().white),
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
              AppLocalizations.of(context)!.medicine,
              style: TextStyle(
                  fontSize: 35,
                  color: ColorPaltte().white,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 320,
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.myMedicne,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: ColorPaltte().darkBlue),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          showMedicationButtonSheet(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: ColorPaltte().darkBlue,
                            ),
                            Text(
                              AppLocalizations.of(context)!.addMedication,
                              style: TextStyle(
                                color: ColorPaltte().darkBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<AsthmaBloc, AsthmaState>(
                    buildWhen: (oldState, newState) {
                      if (newState is SuccessGetMedicationState) {
                        return true;
                      }
                      // if (newState is LoadingState) {
                      //   return true;
                      // }
                      return false;
                    },
                    builder: (context, state) {
                      if (state is SuccessGetMedicationState) {
                        if (state.medications.isNotEmpty) {
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.medications.length,
                              itemBuilder: (context, index) {
                                final medication = state.medications[index];
                                return DataCardWidget(
                                  textEntry1:
                                      "${AppLocalizations.of(context)!.name}: ${medication.medicationName}",
                                  textEntry2:
                                      "${AppLocalizations.of(context)!.days}: ${medication.days.toString()}",
                                  textEntry3:
                                      "${AppLocalizations.of(context)!.startDate}: ${medication.date}",
                                  deleteTap: () {
                                    context.read<AsthmaBloc>().add(
                                          DeleteMedicationEvent(
                                              id: medication.medicationID!),
                                        );
                                  },
                                  imageURL: 'lib/assets/images/pills.png',
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: Text(
                              AppLocalizations.of(context)!.noMedication,
                              style: TextStyle(
                                  fontSize: 18, color: ColorPaltte().darkBlue),
                            ),
                          );
                        }
                      } else if (state is ErrorGetState) {
                        Center(
                            child:
                                Text(AppLocalizations.of(context)!.errorGet));
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text(state.message),
                                ));
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
      ),
    );
  }
}
