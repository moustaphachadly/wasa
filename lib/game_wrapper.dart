import 'package:flutter/material.dart';

class GameWrapper extends StatelessWidget {
  const GameWrapper({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (child != null) child!,
        Positioned(
          left: 30,
          top: 30,
          child: FloatingActionButton.large(
            onPressed: () => Navigator.pop(context),
            elevation: 0,
            child: const Icon(Icons.arrow_back_rounded),
          ),
        ),
      ],
    );
  }
}
