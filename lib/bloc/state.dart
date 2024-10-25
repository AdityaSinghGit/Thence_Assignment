abstract class AudioState {}

class AudioPlaying extends AudioState {}

class AudioPaused extends AudioState {}

class AudioSeeking extends AudioState {
  final double position;
  AudioSeeking(this.position);
}
