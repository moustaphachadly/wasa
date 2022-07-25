/// Inspired by Lingokids.

import 'package:flutter/material.dart';
import 'package:wasa/game_wrapper.dart';
import 'package:wasa/models/game_entry.dart';

import 'list_cell.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({Key? key, required this.gameEntries}) : super(key: key);

  final Iterable<GameEntry> gameEntries;

  void _gameSelectedAtIndex(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameWrapper(
          child: gameEntries.elementAt(index).game,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 50, top: 50, right: 25),
        separatorBuilder: (_, __) => const SizedBox(width: 50),
        itemCount: gameEntries.length,
        itemBuilder: (BuildContext context, int index) => ListCell(
          onTap: () => _gameSelectedAtIndex(context, index),
          child: Center(child: gameEntries.elementAt(index).image),
        ),
      ),
    );
  }
}
