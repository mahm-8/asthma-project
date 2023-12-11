
import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

class DataCardWidget extends StatelessWidget {
  const DataCardWidget({
    super.key,
    this.textEntry1,
    this.textEntry2,
    this.textEntry3,
    this.deleteTap,
  });

  final String? textEntry1, textEntry2, textEntry3;

  final Function()? deleteTap;
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  color: ColorPaltte().lightBlue,
                ),
                child: const Icon(
                  Icons.library_books_rounded,
                  color: Colors.white,
                ),
              ),
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
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "$textEntry2",
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "$textEntry3",
                      maxLines: 1,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: deleteTap,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    color: Colors.red.shade100,
                  ),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red.shade400,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
