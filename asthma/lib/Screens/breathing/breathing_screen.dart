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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 600,
            child: Lottie.asset('lib/assets/images/lottie2.json',
                controller: animationController, onLoaded: (composition) {}),
          ),

          SizedBox(
            width: context.getWidth(divide: 1.5),
            child: ProgressBarWidget(player: player),
          ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
              backgroundColor: const Color(0xffAFD3E2),
              child: AudioControlWidgets(
                player: player,
                controller: animationController,
              ),
              onPressed: () {}),
          //xbox-w@live.com
          //12345Aa!
        ],
      ),
    );
  }

  Future<void> setupAudioPlyer() async {
    player.playbackEventStream.listen((event) {
      print('Playback event: $event');
    }, onError: (Object e, StackTrace stacktrace) {
      print("audio stream error: $e");
    });

    try {
      player.setAudioSource(AudioSource.asset('lib/assets/audio/AAA.mp3'));
    } catch (e) {
      print("error loading audio: $e");
    }
  }
}
