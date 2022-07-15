import 'package:flutter/material.dart';

import 'background_view.dart';
import 'horizontal_list/horizontal_list.dart';

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
      home: Scaffold(
        body: Stack(
          children: const [
            BackgroundView(),
            HorizontalList(),
          ],
        ),
      ),
    );
  }
}
