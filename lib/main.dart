import 'package:flutter/material.dart';

import 'background_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BackgroundView(),
    );
  }
}
