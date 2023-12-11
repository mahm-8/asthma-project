import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioControlWidgets extends StatelessWidget {
  const AudioControlWidgets({
    super.key,
    required this.player,
    required this.controller,
  });
  final AudioPlayer player;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
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
            onPressed: () {
              player.play();
              controller.duration = player.duration ?? Duration.zero;
              controller.forward();
            },
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 30,
              color: Colors.white,
            ),
          );
        } else if (processingState != ProcessingState.completed) {
          return TextButton(
            onPressed: () {
              player.pause();
              controller.stop();
            },
            child: const Icon(
              Icons.pause,
              size: 30,
              color: Colors.white,
            ),
          );
        } else {
          return TextButton(
            onPressed: () {
              player.seek(Duration.zero);
              controller.reset();
              player.play();
              controller.duration = player.duration ?? Duration.zero;
              controller.forward();
            },
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 30,
              color: Colors.white,
            ),
          );
        }
      },
    );
  }
}
