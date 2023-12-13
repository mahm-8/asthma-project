import 'package:asthma/Screens/Data_Symptoms_Screen/components/symptom_bottomsheet.dart';

import '../../helper/imports.dart';
import '../breathing/componnets/custom_appbar.dart';

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
                AppLocalizations.of(context)!.symptom,
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
                          AppLocalizations.of(context)!.mySymptom,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: ColorPaltte().darkBlue),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () async {
                            await showSymptomButtonSheet(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: ColorPaltte().newDarkBlue,
                              ),
                              Text(
                                AppLocalizations.of(context)!.addSymptom,
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
                                        "${AppLocalizations.of(context)!.symptom}: ${symptom.symptomName}",
                                    textEntry2:
                                        "${AppLocalizations.of(context)!.details}: ${symptom.symptomDetails}",
                                    textEntry3:
                                        "${AppLocalizations.of(context)!.intensity}: ${symptom.symptomIntensity}",
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
                                AppLocalizations.of(context)!.noSymtomps,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorPaltte().darkBlue),
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
                          Future.delayed(const Duration(seconds: 1), () {});
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
}
