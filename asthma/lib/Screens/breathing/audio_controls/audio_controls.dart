import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioControlWidgets extends StatelessWidget {
  const AudioControlWidgets({
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
              child: const Text(
                "Start",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          } else if (processingState != ProcessingState.completed) {
            return TextButton(
                onPressed: player.pause,
                child: const Text(
                  "Stop",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ));
          } else {
            return TextButton(
                onPressed: () => player.seek(Duration.zero),
                child: const Text(
                  "Replay",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ));
          }
        });
  }
}


