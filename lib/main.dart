import 'package:flutter/material.dart';
import 'package:wasa/games/piano.dart';

import 'background_view.dart';
import 'horizontal_list/horizontal_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        body: Piano(),
        // body: Stack(
        //   children: const [
        //     BackgroundView(),
        //     HorizontalList(),
        //   ],
        // ),
      ),
    );
  }
}
