import 'package:flutter/material.dart'
    show runApp, StatelessWidget, Widget, BuildContext, MaterialApp, ThemeData;
import 'package:thence_assignment/screen/screen.dart' show AudioPlayerScreen;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const AudioPlayerScreen(),
    );
  }
}
