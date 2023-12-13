import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

class DataCardWidget extends StatelessWidget {
  const DataCardWidget({
    super.key,
    this.textEntry1,
    this.textEntry2,
    this.textEntry3,
    this.deleteTap,
    required this.imageURL,
  });

  final String? textEntry1, textEntry2, textEntry3;
  final String imageURL;

  final Function()? deleteTap;
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  shape: BoxShape.rectangle,
                  color: ColorPaltte().newBlue,
                ),
                child: Image.asset(imageURL)),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$textEntry1",
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ColorPaltte().darkBlue),
                  ),
                  Text(
                    "$textEntry2",
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ColorPaltte().darkBlue),
                  ),
                  Text(
                    "$textEntry3",
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ColorPaltte().darkBlue),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: deleteTap,
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red.shade400,
                ),
              ),
            ),
          ],
        ));
  }
}
