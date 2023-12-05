import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'componnets/audio_circles.dart';
import 'componnets/button_widget.dart';

class BreathingScreen extends StatefulWidget {
  BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  final _player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _setupAudioPlyer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            right: -185,
            bottom: 15,
            child: Image.asset(
              "assets/stack_background.png",
              color: ColorPaltte().lightgreen,
            )),
        Positioned(
            left: -185,
            top: 255,
            child: Image.asset(
              "assets/stack_background.png",
              color: ColorPaltte().lightgreen,
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 300,
            ),
            // audio timer inside the circles stack
            // Text(_player.duration.toString());
            const AudioCircles(),
            Text(_player.duration!.inSeconds.toString()),

            const SizedBox(
              height: 200,
            ),
            ButtonWidget(
              onPress: updateSize,
              widget: _playControlButton(),
            ),
          ],
        ),
      ]),
    );
  }

  void updateSize() {
    setState(() {
      size = large ? 250.0 : 350.0;
      large = !large;
    });
  }

  Future<void> _setupAudioPlyer() async {
    _player.playbackEventStream.listen((event) {
      print('Playback event: $event');
    }, onError: (Object e, StackTrace stacktrace) {
      print("audio stream error: $e");
    });

    try {
      _player
          .setAudioSource(AudioSource.asset('assets/Breathing_Exercise.mp3'));
    } catch (e) {
      print("error loading audio: $e");
    }
  }

  Widget _playControlButton() {
    return StreamBuilder<PlayerState>(
        stream: _player.playerStateStream,
        builder: (context, snapshot) {
          final processingState = snapshot.data?.processingState;
          final playing = snapshot.data?.playing;
          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (playing != true) {
            return TextButton(
              onPressed: _player.play,
              child: const Text(
                "Start",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          } else if (processingState != ProcessingState.completed) {
            return TextButton(
                onPressed: _player.pause,
                child: const Text(
                  "Pause",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ));
          } else {
            return TextButton(
                onPressed: () => _player.seek(Duration.zero),
                child: const Text(
                  "Replay",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ));
          }
        });
  }
}
