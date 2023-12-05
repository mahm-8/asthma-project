import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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
            right: 5,
            bottom: 5,
            child: Image.asset("assets/Bluebackground.png")),
        Positioned(
            left: 55,
            top: 320,
            child: Image.asset("assets/Bluebackground.png")),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 350,
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: 195,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100, shape: BoxShape.circle),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 65,
                  decoration: const BoxDecoration(
                      color: Colors.blue, shape: BoxShape.circle),
                  child: const Text(
                    "5s",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 250,
            ),
            SizedBox(
              height: 55,
              width: 350,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {},
                  child: _playControlButton()),
            ),
          ],
        ),
      ]),
    );
  }

  Future<void> _setupAudioPlyer() async {
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stacktrace) {
      print("audio stream error: $e");
    });

    try {
      _player
          .setAudioSource(AudioSource.asset("assets/Breathing_Exercise.mp3"));
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
            return IconButton(
                onPressed: _player.play, icon: const Icon(Icons.play_arrow));
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
                onPressed: _player.pause, icon: const Icon(Icons.pause));
          } else {
            return IconButton(
                onPressed: () => _player.seek(Duration.zero),
                icon: Icon(Icons.replay));
          }
        });
  }
}
