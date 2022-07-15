/// Inspired by Lingokids.

import 'package:flutter/material.dart';

import 'list_cell.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 50, top: 50, right: 25),
        separatorBuilder: (_, __) => const SizedBox(width: 50),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) => ListCell(
          onTap: () {
            print(index);
          },
          child: Center(child: Text('$index')),
        ),
      ),
    );
  }
}
