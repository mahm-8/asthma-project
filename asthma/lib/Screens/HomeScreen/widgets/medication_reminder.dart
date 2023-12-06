import 'package:asthma/Screens/medication/add_medication_screen.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/navigator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicationReminder extends StatefulWidget {
  const MedicationReminder({Key? key}) : super(key: key);

  @override
  State<MedicationReminder> createState() => _MedicationReminderState();
}

class _MedicationReminderState extends State<MedicationReminder> {
  late List<bool> isCheckedList = List<bool>.filled(7, false);
  String monthName = DateFormat.MMM().format(DateTime.now());

  String getDayName(int index) {
    DateTime now = DateTime.now();
    int currentDayOfWeek = now.weekday;
    int dayOfWeek = ((index + currentDayOfWeek) % 7) + 1;

    switch (dayOfWeek) {
      case 1:
        return 'Sun';
      case 2:
        return 'Mon';
      case 3:
        return 'Tue';
      case 4:
        return 'Wed';
      case 5:
        return 'Thu';
      case 6:
        return 'Fri';
      case 7:
        return 'Sat';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPaltte().newlightBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${DateTime.now().day}, $monthName',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ColorPaltte().darkBlue,
                ),
              ),
              Spacer(),
              TextButton(
                  onPressed: () {
                    context.push(view: AddMedicationScreen());
                  },
                  child: Text(
                    'Add Medication',
                    style: TextStyle(
                        color: ColorPaltte().newDarkBlue, fontSize: 16),
                  ))
            ],
          ),
          Divider(
            thickness: 1,
          ),
          Container(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                String day = getDayName(index);
                return Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      day,
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorPaltte().darkBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        activeColor: ColorPaltte().newDarkBlue,
                        shape: const CircleBorder(),
                        value: isCheckedList[index],
                        onChanged: (value) {
                          setState(() {
                            isCheckedList[index] = value!;
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              '2/4 week completed',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: ColorPaltte().darkBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
