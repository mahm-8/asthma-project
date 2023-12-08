import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

class DropDownMenuComponent extends StatefulWidget {
  const DropDownMenuComponent({super.key});

  @override
  State<DropDownMenuComponent> createState() => _DropDownMenuComponentState();
}

class _DropDownMenuComponentState extends State<DropDownMenuComponent> {
  String? dropdownvalue = 'Low';

  var items = [
    'Low',
    'Medium',
    'High',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Symptom Intensity",
          style: TextStyle(
              fontSize: 18,
              color: ColorPaltte().darkBlue,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
              color: ColorPaltte().newlightBlue,
              borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width * 0.95,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButtonFormField(
            iconDisabledColor: ColorPaltte().darkBlue,
            iconEnabledColor: ColorPaltte().darkBlue,
            decoration: const InputDecoration(
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none)),
            borderRadius: BorderRadius.circular(20),
            value: dropdownvalue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                  style: TextStyle(color: ColorPaltte().darkBlue),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }
}
