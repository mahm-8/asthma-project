import 'dart:typed_data';
import 'package:asthma/Models/symptoms_model.dart';
import 'package:asthma/Services/supabase.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class SymptomTrackerScreen extends StatefulWidget {
  @override
  _SymptomTrackerScreenState createState() => _SymptomTrackerScreenState();
}

class _SymptomTrackerScreenState extends State<SymptomTrackerScreen> {
  List<SymptomsModel> symptoms = [];
  ScreenshotController screenshotController = ScreenshotController();
  String selectedSymptom = 'cough';
  String selectedLevel = 'Low';
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPaltte().white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Symptom',
          style: TextStyle(color: ColorPaltte().darkBlue),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: ColorPaltte().darkBlue,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var container = Column(
                  children: [
                    ...symptoms.map(
                      (e) => Card(
                          child: Column(
                        children: [
                          Text(e.symptomName!),
                          Text(e.symptomDetails!),
                          Text(e.symptomIntensity!)
                        ],
                      )),
                    )
                  ],
                );
                Uint8List? capturedImage =
                    await screenshotController.captureFromWidget(
                        InheritedTheme.captureAll(
                            context, Material(child: container)),
                        delay: const Duration(seconds: 1));
                await SupabaseServer().saveCaptrueImage(capturedImage);
                // saved(capturedImage);
              },
              icon: Icon(Icons.ios_share, color: ColorPaltte().darkBlue))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 300,
              padding: const EdgeInsets.all(12),
              width: context.getWidth(),
              decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Enter a Symptom ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: ColorPaltte().darkBlue),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          ShowButtonSheet(context);
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
                  if (symptoms != [])
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: symptoms.length,
                        itemBuilder: (context, index) {
                          final symptom = symptoms[index];
                          return Card(
                              child: Column(
                            children: [
                              Text(symptom.symptomName!),
                              Text(symptom.symptomDetails!),
                              Text(symptom.symptomIntensity!)
                            ],
                          ));
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> ShowButtonSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 2,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16)),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(20),
                  iconDisabledColor: ColorPaltte().darkBlue,
                  iconEnabledColor: ColorPaltte().darkBlue,
                  isExpanded: true,
                  value: selectedSymptom,
                  hint: const Text('Select Symptom'),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(20),
                  iconDisabledColor: ColorPaltte().darkBlue,
                  iconEnabledColor: ColorPaltte().darkBlue,
                  isExpanded: true,
                  value: selectedLevel,
                  hint: const Text('Select Level'),
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
              TextField(
                maxLines: 4,
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: 'Enter Description',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  setState(() {
                    symptoms.add(SymptomsModel(
                        symptomName: selectedSymptom,
                        symptomDetails: descriptionController.text,
                        symptomIntensity: selectedLevel));
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  height: context.getHeight() * 0.04,
                  width: context.getWidth() * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorPaltte().newDarkBlue,
                  ),
                  child: Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: ColorPaltte().white),
                    ),
                  ),
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
        );
      },
    );
  }
}
