import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/screen_dimensions.dart';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'audio_controls/audio_controls.dart';
import 'componnets/audio_circles.dart';
import 'componnets/button_widget.dart';
import 'audio_controls/progress_bar_widget.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    setupAudioPlyer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            right: -185,
            bottom: 15,
            child: Image.asset(
              "lib/assets/images/stack_background.png",
              color: ColorPaltte().newlightBlue,
            )),
        Positioned(
            left: -185,
            top: 235,
            child: Image.asset(
              "lib/assets/images/stack_background.png",
              color: ColorPaltte().newlightBlue,
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: context.getWidth(),
            ),
            //AudioCircles()
            const SizedBox(
              height: 400,
              // child:
            ),
            const SizedBox(
              height: 75,
            ),
            SizedBox(
              width: context.getWidth(divide: 1.5),
              child: ProgressBarWidget(player: player),
            ),
            const SizedBox(
              height: 15,
            ),
            FloatingActionButton(
                backgroundColor: ColorPaltte().newDarkBlue,
                child: AudioControlWidgets(player: player),
                onPressed: () {}),
            // ButtonWidget(
            //   onPress: _togglePlay,
            //   widget: AudioControlWidgets(player: player),
            // ),
          ],
        ),
      ]),
    );
  }

  Future<void> setupAudioPlyer() async {
    player.playbackEventStream.listen((event) {
      print('Playback event: $event');
    }, onError: (Object e, StackTrace stacktrace) {
      print("audio stream error: $e");
    });

    try {
      player.setAudioSource(
          AudioSource.asset('lib/assets/audio/Breathing_Exercise.mp3'));
    } catch (e) {
      print("error loading audio: $e");
    }
  }
}
