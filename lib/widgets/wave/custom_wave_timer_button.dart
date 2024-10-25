import 'package:flutter/material.dart'
    show
        Alignment,
        BoxDecoration,
        BoxShadow,
        BoxShape,
        BuildContext,
        Center,
        Color,
        Colors,
        Container,
        CustomPaint,
        GestureDetector,
        Icon,
        Icons,
        Key,
        LinearGradient,
        Offset,
        Positioned,
        RenderBox,
        Size,
        Stack,
        State,
        StatefulWidget,
        Text,
        TextStyle,
        Widget;
import 'package:audioplayers/audioplayers.dart' show AudioPlayer, UrlSource;
import 'package:thence_assignment/widgets/wave/custom_wave_painter.dart'
    show WaveformPainter;

//
// NOTE: The logic used to create custom waves is inspired from the *flutter_audio_waveforms* package
//
class CustomWaveTimerAndButton extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final double waveformHeight;
  final String audioUrl;
  final bool isPlaying;

  const CustomWaveTimerAndButton({
    Key? key,
    required this.audioPlayer,
    required this.waveformHeight,
    required this.audioUrl,
    required this.isPlaying,
  }) : super(key: key);

  @override
  _CustomWaveTimerAndButtonState createState() =>
      _CustomWaveTimerAndButtonState();
}

class _CustomWaveTimerAndButtonState extends State<CustomWaveTimerAndButton> {
  Duration _audioDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;
  bool _isDragging = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    // Duration of the audio
    widget.audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _audioDuration = duration;
      });
    });

    // Position of the audio
    widget.audioPlayer.onPositionChanged.listen((position) {
      if (!_isDragging) {
        setState(() {
          _currentPosition = position;
        });
      }
    });

    // Listens if the audio is complete
    widget.audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _isPlaying = false;
        _currentPosition = Duration.zero;
      });
    });
  }

  // Duration to m/s format
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Waveform
        Positioned(
          left: 0,
          right: 0,
          bottom: 120,
          child: gestureAction(context),
        ),
        // Timer
        Positioned(
          left: 0,
          right: 0,
          bottom: 110,
          child: Center(
            child: Text(
              _formatDuration(_currentPosition),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        // Play/Pause button
        Positioned(
          left: 0,
          right: 0,
          bottom: 30,
          child: Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isPlaying = !_isPlaying;
                  if (_isPlaying) {
                    widget.audioPlayer.play(UrlSource(widget.audioUrl));
                  } else {
                    widget.audioPlayer.pause();
                  }
                });
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFE0E0E0),
                      Color(0xFFB0B0B0),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 10,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: Colors.grey[800],
                  size: 50,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Function to handle wave gesture
  GestureDetector gestureAction(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (_) => setState(() => _isDragging = true),
      onHorizontalDragUpdate: (details) {
        final renderBox = context.findRenderObject() as RenderBox;
        final localPosition = renderBox.globalToLocal(details.globalPosition);
        final relativePosition = localPosition.dx / renderBox.size.width;
        setState(() => _currentPosition = Duration(
            milliseconds:
                (relativePosition * _audioDuration.inMilliseconds).toInt()));
      },
      onHorizontalDragEnd: (_) {
        setState(() => _isDragging = false);
        widget.audioPlayer.seek(_currentPosition);
      },
      onTapDown: (details) {
        final renderBox = context.findRenderObject() as RenderBox;
        final localPosition = renderBox.globalToLocal(details.globalPosition);
        final relativePosition = localPosition.dx / renderBox.size.width;
        setState(() => _currentPosition = Duration(
            milliseconds:
                (relativePosition * _audioDuration.inMilliseconds).toInt()));
        widget.audioPlayer.seek(_currentPosition);
      },
      child: CustomPaint(
        size: Size(double.infinity, widget.waveformHeight),
        painter: WaveformPainter(
          progressFraction: _audioDuration.inMilliseconds == 0
              ? 0
              : _currentPosition.inMilliseconds / _audioDuration.inMilliseconds,
        ),
      ),
    );
  }
}
