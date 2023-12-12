// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  InformationCard({
    super.key,
  });
  TextEditingController taskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 300,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 141, 181, 199),
          borderRadius: BorderRadius.only(
              // topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Expanded(
        child: Container(
          padding: const EdgeInsets.all(20),
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
              const Spacer(),
              const Text(
                'Tour Task Today',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 1,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Column(
                              children: [
                                const Text('add new task '),
                                TextField(
                                  controller: taskController,
                                )
                              ],
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {}, child: const Text('add task'))
                            ],
                          ));
                },
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Row(children: [
                    Icon(
                      Icons.add,
                      size: 25,
                    ),
                    Text('Create New')
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
