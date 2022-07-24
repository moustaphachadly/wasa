/// Inspired by High Contrast Shapes and Animations by Hey Bear Sensory.
/// https://www.youtube.com/watch?v=Jv_iVQdkuuM

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sound_generator/sound_generator.dart';

const int columnsNumber = 8;
const double spacing = 15.0;

class Circles extends StatefulWidget {
  const Circles({Key? key}) : super(key: key);

  @override
  State<Circles> createState() => _CirclesState();
}

class _CirclesState extends State<Circles> {
  final key = GlobalKey();
  int? _selectingIndex;
  int sampleRate = 96000;

  @override
  void initState() {
    super.initState();
    SoundGenerator.init(sampleRate);
  }

  @override
  void dispose() {
    super.dispose();
    SoundGenerator.release();
  }

  _detectTapedItem(PointerEvent event) {
    final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    final result = BoxHitTestResult();
    Offset local = box.globalToLocal(event.position);
    if (box.hitTest(result, position: local)) {
      for (final hit in result.path) {
        /// temporary variable so that the [is] allows access of [index]
        final target = hit.target;
        if (target is _Circle && target.index != _selectingIndex) {
          _selectIndex(target.index);
        }
      }
    }
  }

  _selectIndex(int index) {
    _play(index);
    setState(() {
      _selectingIndex = index;
    });
  }

  void _clearSelection(PointerUpEvent event) {
    setState(() {
      _selectingIndex = null;
    });
  }

  void _play(int index) {
    SoundGenerator.stop();
    SoundGenerator.setFrequency(20 + index * 100);
    SoundGenerator.play();

    Future.delayed(const Duration(milliseconds: 200), () {
      SoundGenerator.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final columnSize = size.width / columnsNumber;
    final rowsNumber = (size.height / columnSize).floor();

    return Listener(
      onPointerDown: _detectTapedItem,
      onPointerMove: _detectTapedItem,
      onPointerUp: _clearSelection,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: GridView.builder(
            key: key,
            itemCount: columnsNumber * rowsNumber,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(spacing / 2),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnsNumber,
              childAspectRatio: 1.0,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            itemBuilder: (context, index) {
              return Circle(
                index: index,
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: _selectingIndex == index ? 0.5 : 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Circle extends SingleChildRenderObjectWidget {
  final int index;

  const Circle({required Widget child, required this.index, Key? key})
      : super(child: child, key: key);

  @override
  _Circle createRenderObject(BuildContext context) {
    return _Circle()..index = index;
  }

  @override
  void updateRenderObject(BuildContext context, _Circle renderObject) {
    renderObject..index = index;
  }
}

class _Circle extends RenderProxyBox {
  late int index;
}
