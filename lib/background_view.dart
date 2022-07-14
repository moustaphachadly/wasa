/// Colors from https://www.behance.net/Jxtrlim

import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class BackgroundView extends StatelessWidget {
  const BackgroundView({Key? key}) : super(key: key);

  static const _backgroundColor = Color(0xFF10403B);

  static const _colors = [
    Color(0xFF8AA6A3),
    Color(0xFF127369),
  ];

  static const _durations = [
    50000,
    40000,
  ];

  static const _heightPercentages = [
    0.65,
    0.66,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaveWidget(
        config: CustomConfig(
          colors: _colors,
          durations: _durations,
          heightPercentages: _heightPercentages,
        ),
        backgroundColor: _backgroundColor,
        size: const Size(double.infinity, double.infinity),
        waveAmplitude: 0,
      ),
    );
  }
}
