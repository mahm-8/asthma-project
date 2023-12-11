import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'audio_controls/audio_controls.dart';
import 'package:lottie/lottie.dart';
import 'audio_controls/progress_bar_widget.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with TickerProviderStateMixin {
  final player = AudioPlayer();
  late final AnimationController animationController;
  bool isPlayed = false;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    animationController = AnimationController(vsync: this);
    setupAudioPlyer();
  }

  @override
  void dispose() {
    player.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Positioned(
        //     right: -185,
        //     bottom: 15,
        //     child: Image.asset(
        //       "lib/assets/images/stack_background.png",
        //       color: ColorPaltte().newlightBlue,
        //     )),
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
            SizedBox(
              height: 400,
              child: Lottie.asset('lib/assets/images/lottie1.json',
                  controller: animationController, onLoaded: (composition) {}),
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
                child: AudioControlWidgets(
                  player: player,
                  controller: animationController,
                ),
                onPressed: () {}),
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
