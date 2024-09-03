import 'package:flutter/material.dart';
import 'dart:math';

class SunArcPainter extends CustomPainter {
  final bool isweather;
  final double
      sunPosition; // From 0.0 to 1.0, where 0.0 is sunrise and 1.0 is sunset
  final String sunriseTime;
  final String sunsetTime;

  SunArcPainter({
    required this.isweather,
    required this.sunPosition,
    required this.sunriseTime,
    required this.sunsetTime,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint arcPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    double centerX = size.width / 2;
    double radius = size.width / 2 - 20;
    double startAngle = pi;
    double sweepAngle = pi; // semicircle

    // Draw the arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, size.height / 2), radius: radius),
      startAngle,
      sweepAngle,
      false,
      arcPaint,
    );

    // Calculate sun position
    double sunX = centerX + radius * cos(startAngle + sweepAngle * sunPosition);
    double sunY =
        size.height / 2 + radius * sin(startAngle + sweepAngle * sunPosition);

    // Draw the sun using an icon with a background
    drawIconAtPosition(
        canvas, sunX, sunY, Icons.wb_sunny, Colors.yellow, true, null);

    // Draw sunrise and sunset icons with times below them
    drawIcon(canvas, size, radius, startAngle, Icons.wb_sunny, false,
        sunriseTime); // Sunrise icon
    drawIcon(canvas, size, radius, startAngle + sweepAngle, Icons.brightness_2,
        false, sunsetTime); // Sunset icon
  }

  void drawIcon(Canvas canvas, Size size, double radius, double angle,
      IconData icon, bool hasBackground, String? time) {
    double centerX = size.width / 2;
    double x = centerX + radius * cos(angle);
    double y = size.height / 2 + radius * sin(angle);

    drawIconAtPosition(canvas, x, y, icon, Colors.black, hasBackground, time);
  }

  void drawIconAtPosition(Canvas canvas, double x, double y, IconData icon,
      Color color, bool hasBackground, String? time) {
    double iconSize = 30.0;

    if (hasBackground) {
      // Draw circular background
      Paint backgroundPaint = Paint()
        ..color = Colors.amber[600]!
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), iconSize / 1.5, backgroundPaint);
    }

    // Draw icon
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: iconSize,
          fontFamily: icon.fontFamily,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
        canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));

    // Draw time text below the icon
    if (time != null) {
      drawTextAtPosition(canvas, x, y + iconSize / 1.5 + 10, time,
          isweather ? const Color.fromARGB(255, 6, 6, 75) : Colors.white);
    }
  }

  void drawTextAtPosition(
      Canvas canvas, double x, double y, String text, Color color) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 18,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class SunArcAnimation extends StatefulWidget {
  final bool isweather;
  final String sunrisseTime;
  final String sunsetTime;

  const SunArcAnimation({
    required this.isweather,
    required this.sunrisseTime,
    required this.sunsetTime,
    Key? key,
  }) : super(key: key);

  @override
  _SunArcAnimationState createState() => _SunArcAnimationState();
}

class _SunArcAnimationState extends State<SunArcAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Define sunrise and sunset times
    TimeOfDay sunrise = const TimeOfDay(hour: 4, minute: 44);
    TimeOfDay sunset = const TimeOfDay(hour: 18, minute: 50);

    // Format times as strings
    String sunriseTime =
        '${sunrise.hour}:${sunrise.minute.toString().padLeft(2, '0')}';
    String sunsetTime =
        '${sunset.hour}:${sunset.minute.toString().padLeft(2, '0')}';

    // Calculate the total duration of daylight in minutes
    final int totalMinutes =
        (sunset.hour - sunrise.hour) * 60 + (sunset.minute - sunrise.minute);

    // Calculate the current position of the sun based on the current time
    TimeOfDay now = TimeOfDay.now();
    final int currentMinutes =
        (now.hour - sunrise.hour) * 60 + (now.minute - sunrise.minute);
    final double sunPosition = currentMinutes / totalMinutes;

    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Duration for the animation
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 0.5)
        .animate(_controller) // this end is end of sun
      ..addListener(() {
        setState(() {});
      });

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: SunArcPainter(
            isweather: widget.isweather,
          sunPosition: _animation.value,
          sunriseTime: widget.sunrisseTime,
          sunsetTime: widget.sunsetTime,
        ),
        size: const Size(300, 350),
      ),
    );
  }
}
