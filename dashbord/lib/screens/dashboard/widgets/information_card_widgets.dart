// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InformationCard extends StatelessWidget {
  InformationCard({super.key});

  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Color(0xff146C94),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/Dashboard-bro.png',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 20),
          const Text(
            'Wadha Almutairi',
            style: TextStyle(fontSize: 16),
          ),
          const Text(
            'IT',
            style: TextStyle(fontSize: 16),
          ),
          const Text(
            'Location: Riyadh',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 30,
          ),
          const Text(
            'Your Task Today',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Container(
            height: 1,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: 150,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 50, 120, 152)),
            child: Row(
              children: [
                Icon(
                  Icons.done_outline_rounded,
                  size: 18,
                ),
                Text('  workout'),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Add New Task'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  content: SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 4,
                    child: SizedBox(
                      height: 10,
                      child: TextField(
                        controller: taskController,
                        decoration: InputDecoration(
                          hintText: 'Write task',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Confirm'),
                    ),
                  ],

                ),
              );
            },
            child: Container(
              height: 30,
              width: 120,
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 31, 59, 72),
                    size: 20,
                  ),
                  Text(
                    'Create New',
                    style: TextStyle(color: Color.fromARGB(255, 31, 59, 72)),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
