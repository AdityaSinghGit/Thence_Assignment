import 'package:flutter/material.dart'
    show
        Canvas,
        Color,
        Colors,
        CustomPainter,
        Offset,
        Paint,
        PaintingStyle,
        Size,
        StrokeCap;

class WaveformPainter extends CustomPainter {
  final double progressFraction;

  WaveformPainter({
    required this.progressFraction,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the completed portion (progress)
    final paintComplete = Paint()
      ..color = Colors.white
      ..strokeWidth = 5.0 // Thicker lines
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Smooth, rounded edges

    // Paint for the remaining part of the waveform
    final paintRemaining = Paint()
      ..color = const Color(0xFF747578)
      ..strokeWidth = 5.0 // Thicker lines
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Smooth, rounded edges

    // Define the custom wave pattern based on the SVG
    int barCount = (size.width / 10).floor(); // Fewer bars for larger gaps
    double barWidth = size.width / barCount;

    // Define a custom pattern for bar heights (can be adjusted)
    List<double> wavePattern = [
      0.015,
      0.001,
      0.08,
      0.2,
      0.28,
      0.2,
      0.05,
      0.01,
      0.05,
      0.08,
      0.12,
      0.05,
      0.1,
      0.2,
      0.3,
      0.4,
      0.3,
      0.15,
      0.1,
      0.1,
    ];

    // Draw the waveform bars
    for (int i = 0; i < barCount; i++) {
      double x = i * barWidth;
      int patternIndex = i % wavePattern.length;
      double barHeight = wavePattern[patternIndex] * size.height;

      // Draw symmetrical bars extending upwards and downwards from the center
      if (x < size.width * progressFraction) {
        canvas.drawLine(
          Offset(x, size.height / 2 - barHeight / 2),
          Offset(x, size.height / 2 + barHeight / 2),
          paintComplete,
        );
      } else {
        canvas.drawLine(
          Offset(x, size.height / 2 - barHeight / 2),
          Offset(x, size.height / 2 + barHeight / 2),
          paintRemaining,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
