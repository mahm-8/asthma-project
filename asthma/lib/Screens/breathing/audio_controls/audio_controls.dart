import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioControlWidgets extends StatelessWidget {
  AudioControlWidgets({
    super.key,
    required this.player,
  });

  final AudioPlayer player;

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
              onPressed: player.play,
              child: const Icon(
                Icons.play_arrow_rounded,
                size: 30,
                color: Colors.white,
              ),
              // Text(
              //   "Start",
              //   style: TextStyle(color: Colors.white, fontSize: 18),
              // ),
            );
          } else if (processingState != ProcessingState.completed) {
            return TextButton(
              onPressed: player.pause,
              child: const Icon(
                Icons.pause,
                size: 30,
                color: Colors.white,
              ),
            );
          } else {
            return TextButton(
              onPressed: () => player.seek(Duration.zero),
              child: const Icon(
                Icons.replay,
                size: 30,
                color: Colors.white,
              ),
            );
          }
        });
  }
}
