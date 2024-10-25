import 'package:audioplayers/audioplayers.dart' show AudioPlayer, PlayerState;
import 'package:flutter/material.dart'
    show
        StatefulWidget,
        State,
        Widget,
        BuildContext,
        Scaffold,
        Colors,
        Stack,
        Center;
import 'package:thence_assignment/widgets/wave/custom_wave_timer_button.dart'
    show CustomWaveTimerAndButton;
import 'package:thence_assignment/widgets/background_svg.dart'
    show BackgroundImage;
import 'package:thence_assignment/widgets/bottom_container_and_text.dart'
    show BottomContainerWithTitle;

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  final String _audioUrl =
      'https://codeskulptor-demos.commondatastorage.googleapis.com/descent/background%20music.mp3';

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          // Background Image
          const BackgroundImage(),
          // Bottom Container
          const BottomContainerWithTitle(),
          // Customized Audio Wave with Timer and Play/Pause button
          Center(
            child: CustomWaveTimerAndButton(
              audioPlayer: _audioPlayer,
              waveformHeight: 150,
              audioUrl: _audioUrl,
              isPlaying: _isPlaying,
            ),
          ),
        ],
      ),
    );
  }
}
