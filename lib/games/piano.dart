import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const List<String> notes = [
  'a1',
  'b1',
  'c1',
  'd1',
  'e1',
  'f1',
  'g1',
  'ab1',
  'bb1',
  'db1',
  'eb1',
  'gb1'
];

class Piano extends StatefulWidget {
  const Piano({Key? key}) : super(key: key);

  @override
  State<Piano> createState() => _PianoState();
}

class _PianoState extends State<Piano> {
  final List<AudioPlayer> players = List.generate(notes.length,
      (index) => AudioPlayer(playerId: notes[index])); // Number of keys

  AudioPlayer? getPlayer(String id) =>
      players.firstWhereOrNull((e) => e.playerId == id);

  Future<void> playAudio(String fileName) async {
    getPlayer(fileName)?.play(AssetSource('piano_notes/$fileName.mp3'));
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            _buildPianoButtons(),
            _buildPianoSuperButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPianoButtons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PianoButton(onKeyPress: () => playAudio('a1')),
        PianoButton(onKeyPress: () => playAudio('b1')),
        PianoButton(onKeyPress: () => playAudio('c1')),
        PianoButton(onKeyPress: () => playAudio('d1')),
        PianoButton(onKeyPress: () => playAudio('e1')),
        PianoButton(onKeyPress: () => playAudio('f1')),
        PianoButton(onKeyPress: () => playAudio('g1')),
      ],
    );
  }

  Widget _buildPianoSuperButtons() {
    return Row(
      children: [
        PianoButtonWithSuperKey(place: 0, onKeyPress: () => playAudio('ab1')),
        PianoButtonWithSuperKey(place: 1, onKeyPress: () => playAudio('bb1')),
        PianoButtonWithSuperKey(place: 2, onKeyPress: () => playAudio('db1')),
        const PianoButtonWithSuperKey.empty(),
        PianoButtonWithSuperKey(place: 4, onKeyPress: () => playAudio('eb1')),
        PianoButtonWithSuperKey(place: 5, onKeyPress: () => playAudio('gb1')),
      ],
    );
  }
}

class PianoButtonWithSuperKey extends StatelessWidget {
  final int? place;
  final VoidCallback? onKeyPress;
  final bool isEmpty;

  const PianoButtonWithSuperKey({
    Key? key,
    required this.place,
    required this.onKeyPress,
  })  : isEmpty = false,
        super(key: key);

  const PianoButtonWithSuperKey.empty({Key? key})
      : place = null,
        onKeyPress = null,
        isEmpty = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final normalButtonWidth = size.width / 7;
    final portion = normalButtonWidth / 3;
    final body = isEmpty
        ? SizedBox(width: portion * 2)
        : SizedBox(
            width: portion * 2,
            height: size.height * 3 / 5,
            child: ElevatedButton(
              onPressed: onKeyPress,
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: null,
            ),
          );

    return Row(
      children: [
        if (place == 0) SizedBox(width: portion),
        SizedBox(width: portion),
        body,
      ],
    );
  }
}

class PianoButton extends StatelessWidget {
  final VoidCallback onKeyPress;

  const PianoButton({Key? key, required this.onKeyPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 8.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ElevatedButton(
            onPressed: onKeyPress,
            style: ElevatedButton.styleFrom(primary: Colors.grey[300]),
            child: null,
          ),
        ),
      ),
    );
  }
}
