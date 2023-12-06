import 'package:asthma/Screens/chatGPT/widgets/card_chat.dart';
import 'package:asthma/Services/api_networking.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
import 'package:flutter/material.dart';

class ChatGPT extends StatefulWidget {
  const ChatGPT({
    super.key,
  });
  @override
  State<ChatGPT> createState() => _ChatGPTState();
}

class _ChatGPTState extends State<ChatGPT> {
  TextEditingController controllerAsk = TextEditingController();
  List<QuestionAnswer> questionAnswers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPaltte().white,
        body: Stack(
          children: [
            Center(
                child: Image.asset(
              'lib/assets/images/robot.png',
              height: context.getHeight(),
              width: context.getWidth(),
            )),
            Column(
              children: [
                Flexible(
                  flex: 10,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: questionAnswers.length * 2,
                    itemBuilder: (context, index) {
                      if (index % 2 == 0) {
                        return CardUser(
                          title: questionAnswers[index ~/ 2].question,
                          isUser: true,
                        );
                      } else {
                        return CardUser(
                          title: questionAnswers[(index - 1) ~/ 2].answer,
                          isUser: false,
                        );
                      }
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 4,
                          child: SizedBox(
                            height: 50,
                            child: TextField(
                              controller: controllerAsk,
                              decoration: InputDecoration(
                                  hintText: 'write your qusetion?',
                                  hintStyle: TextStyle(fontSize: 18),
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  contentPadding:
                                      const EdgeInsets.only(left: 10)),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              final question = controllerAsk.text;
                              final answerGpt =
                                  await Networking().contectGpt(msg: question);
                              setState(() {
                                questionAnswers.add(QuestionAnswer(
                                    question: question, answer: answerGpt));
                              });
                              controllerAsk.clear();
                              setState(() {});
                            },
                            child: Text('send',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: ColorPaltte().darkBlue)))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

class QuestionAnswer {
  final String question;
  final String answer;

  QuestionAnswer({
    required this.question,
    required this.answer,
  });
}
