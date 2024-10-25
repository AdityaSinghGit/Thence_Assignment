abstract class AudioEvent {}

class PlayEvent extends AudioEvent {}

class PauseEvent extends AudioEvent {}

class SeekEvent extends AudioEvent {
  final double position;
  SeekEvent(this.position);
}
