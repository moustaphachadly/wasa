import 'package:flutter/material.dart';

const double cellWidth = 300;
const double cellHeight = 200;
const double shadowHeight = 20;

class ListCell extends StatefulWidget {
  const ListCell({Key? key, required this.onTap, this.child}) : super(key: key);

  final VoidCallback onTap;
  final Widget? child;

  @override
  State<ListCell> createState() => _ListCellState();
}

class _ListCellState extends State<ListCell> {
  double _top = 0;

  void _setHighlighted(bool highlighted) {
    setState(() => _top = highlighted ? shadowHeight : 0);
  }

  bool _isInsideBox(BoxConstraints constraints, Offset localPosition) {
    return localPosition.dx >= 0.0 &&
        localPosition.dy >= 0.0 &&
        localPosition.dx <= constraints.maxWidth &&
        localPosition.dy <= constraints.maxHeight;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cellWidth,
      height: cellHeight,
      child: LayoutBuilder(builder: (context, constraints) {
        return Listener(
          onPointerDown: (details) {
            _setHighlighted(true);
          },
          onPointerMove: (details) {
            _setHighlighted(_isInsideBox(constraints, details.localPosition));
          },
          onPointerUp: (details) {
            _setHighlighted(false);
            if (_isInsideBox(constraints, details.localPosition)) {
              widget.onTap();
            }
          },
          onPointerCancel: (d) {
            _setHighlighted(false);
          },
          child: Stack(
            children: [
              const Positioned(
                top: shadowHeight,
                child: RoundedBox(color: Colors.blueAccent),
              ),
              AnimatedPositioned(
                top: _top,
                duration: const Duration(milliseconds: 150),
                child: RoundedBox(
                  color: Colors.white,
                  child: widget.child,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class RoundedBox extends StatelessWidget {
  const RoundedBox({Key? key, this.color, this.child}) : super(key: key);

  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cellWidth,
      height: cellHeight - shadowHeight,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(40),
      ),
      child: child,
    );
  }
}
