import 'package:flutter/material.dart';

import 'background_view.dart';
import 'games/circles.dart';
import 'games/piano.dart';
import 'horizontal_list/horizontal_list.dart';
import 'models/game_entry.dart';

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
        body: Stack(
          children: [
            const BackgroundView(),
            HorizontalList(gameEntries: [
              GameEntry(Image.asset('assets/images/games/piano.png',), Piano()),
              GameEntry(Image.asset('assets/images/games/circles.png',), Circles()),
            ],),
          ],
        ),
      ),
    );
  }
}
