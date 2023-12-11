import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:asthma/helper/imports.dart';


class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({
    super.key,
    required this.player,
  });

  final AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration?>(
        stream: player.positionStream,
        builder: (context, snapshot) {
          return ProgressBar(
            
            // timeLabelType: TimeLabelType.totalTime,
            timeLabelTextStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: ColorPaltte().darkBlue),
            timeLabelLocation: TimeLabelLocation.sides,
            thumbColor: ColorPaltte().darkBlue,
            progressBarColor: ColorPaltte().darkBlue,
            baseBarColor: ColorPaltte().newDarkBlue,
            barCapShape: BarCapShape.round,
            progress: snapshot.data ?? Duration.zero,
            buffered: player.bufferedPosition,
            total: player.duration ?? Duration.zero,
            onSeek: (duration) {
              player.seek(duration);
            },
          );
        });
  }
}
