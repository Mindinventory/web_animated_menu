import 'package:flutter/material.dart';

///This is the Tile which performs animation
class SwingAcrossAxisAnimationTile extends StatelessWidget {
  final int index;
  final double value;
  final Widget child;

  const SwingAcrossAxisAnimationTile(
      {Key? key, required this.value, required this.child, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: index == 0
          ? const EdgeInsets.only(top: 10)
          : const EdgeInsets.only(top: 0),
      child: Opacity(
        opacity: 1 - value,
        child: Transform(
          alignment: Alignment.bottomCenter,
          transform: Matrix4.identity()
            ..translate(0, -10, 0)
            ..rotateZ(value / 0.05)
            ..translate(0, 10, 110),
          child: child,
        ),
      ),
    );
  }
}
