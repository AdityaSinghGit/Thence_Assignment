import 'package:flutter_bloc/flutter_bloc.dart' show Bloc;
import 'package:audioplayers/audioplayers.dart' show AudioPlayer;
import 'event.dart' as event show AudioEvent, PauseEvent, PlayEvent, SeekEvent;
import 'state.dart' show AudioPaused, AudioPlaying, AudioSeeking, AudioState;

class AudioBloc extends Bloc<event.AudioEvent, AudioState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration? totalDuration;

  Stream<Duration> get currentPositionStream => _audioPlayer.onPositionChanged;

  AudioBloc() : super(AudioPaused()) {
    _audioPlayer.onDurationChanged.listen((duration) {
      totalDuration = duration;
    });

    // To handle play event
    on<event.PlayEvent>((event, emit) async {
      await _audioPlayer.resume();
      emit(AudioPlaying());
    });

    // To handle pause event
    on<event.PauseEvent>((event, emit) async {
      await _audioPlayer.pause();
      emit(AudioPaused());
    });

    // To handle seek event
    on<event.SeekEvent>((event, emit) async {
      final totalDuration = this.totalDuration?.inSeconds ?? 1;
      if (totalDuration > 0) {
        final validPosition = event.position.clamp(0, totalDuration).toDouble();
        await _audioPlayer.seek(Duration(seconds: validPosition.toInt()));
        emit(AudioSeeking(validPosition));
      }
    });
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
