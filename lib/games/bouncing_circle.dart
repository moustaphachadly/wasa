import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class BouncingCircle extends StatefulWidget {
  const BouncingCircle({Key? key}) : super(key: key);

  @override
  State<BouncingCircle> createState() => _BouncingCircleState();
}

class _BouncingCircleState extends State<BouncingCircle> {
  final double _circleSize = 200.0;
  final double _animationStep = 50.0;

  Offset? _circlePosition;
  double _slope = 0;
  double _xDistance = 0;
  int _tapCount = 0;
  Timer? _moveRightTimer;
  Timer? _moveLeftTimer;

  final _player = AudioPlayer();

  void _playSound() {
    _player.stop();
    _player.resume();
  }

  @override
  void initState() {
    _player.setSourceAsset('audios/negative-tone-interface-tap.wav');

    // Initial velocity.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final dx = Random().nextDouble() * (2 * _animationStep) + -_animationStep;
      final dy = Random().nextDouble() * (2 * _animationStep) + -_animationStep;
      final initialVelocity = _circlePosition!.translate(dx, dy);
      // TODO: Following is almost same as PositionedTapDetector2's tap callback.
      _tapCount++;
      _slope = (-initialVelocity.dy + _circlePosition!.dy) /
          (initialVelocity.dx - _circlePosition!.dx);
      if (initialVelocity.dx < _circlePosition!.dx) {
        moveLeft(_slope, _tapCount);
      }
      if (initialVelocity.dx > _circlePosition!.dx) {
        moveRight(_slope, _tapCount);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _moveLeftTimer?.cancel();
    _moveRightTimer?.cancel();
    _player.dispose();
    super.dispose();
  }

  void moveRight(double slope, int i) {
    _moveRightTimer = Timer.periodic(const Duration(milliseconds: 8), (timer) {
      if (_tapCount != i) {
        timer.cancel();
//Stop moving in this direction when the screen is tapped again
      }
      _xDistance = sqrt(_animationStep / (1 + pow(slope, 2)));
      setState(() {
        _circlePosition = Offset(_circlePosition!.dx + _xDistance,
            _circlePosition!.dy - slope * _xDistance);
      });

//if the ball bounces off the top or bottom

      if (_circlePosition!.dy < 0 ||
          _circlePosition!.dy >
              MediaQuery.of(context).size.height - _circleSize) {
        timer.cancel();
        _playSound();
        moveRight(-slope, i);
      }
//if the ball bounces off the right
      if (_circlePosition!.dx >
          MediaQuery.of(context).size.width - _circleSize) {
        timer.cancel();
        _playSound();
        moveLeft(-slope, i);
      }
    });
  }

  void moveLeft(double slope, int i) {
    _moveLeftTimer = Timer.periodic(const Duration(milliseconds: 8), (timer) {
      if (_tapCount != i) {
        timer.cancel();
//Stop moving in this direction when the screen is tapped again

      }
      _xDistance = sqrt(_animationStep / (1 + pow(slope, 2)));
      setState(() {
        _circlePosition = Offset(_circlePosition!.dx - _xDistance,
            _circlePosition!.dy + slope * _xDistance);
      });

//if the ball bounces off the top or bottom
      if (_circlePosition!.dy < 0 ||
          _circlePosition!.dy >
              MediaQuery.of(context).size.height - _circleSize) {
        timer.cancel();
        _playSound();
        moveLeft(-slope, i);
      }
//if the ball bounces off the left
      if (_circlePosition!.dx < 0) {
        timer.cancel();
        _playSound();
        moveRight(-slope, i);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _circlePosition ??= Offset(
        (MediaQuery.of(context).size.width - _circleSize) / 2,
        (MediaQuery.of(context).size.height - _circleSize) / 2);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PositionedTapDetector2(
            onTap: (position) {
              _tapCount++;
              _slope = (-position.global.dy + _circlePosition!.dy) /
                  (position.global.dx - _circlePosition!.dx);
              if (position.global.dx < _circlePosition!.dx) {
                moveLeft(_slope, _tapCount);
              }
              if (position.global.dx > _circlePosition!.dx) {
                moveRight(_slope, _tapCount);
              }
            },
          ),
          Positioned(
            left: _circlePosition!.dx,
            top: _circlePosition!.dy,
            child: CustomPaint(
              size: Size(_circleSize, _circleSize),
              painter: CirclePainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  Paint _drawConcentricCircles(double strokeWidth) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 8;
    final innerSize = size / 2;

    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _drawConcentricCircles(strokeWidth),
    );
    canvas.drawCircle(
      Offset(innerSize.width, innerSize.width),
      innerSize.width / 2,
      _drawConcentricCircles(strokeWidth),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
