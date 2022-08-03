import 'dart:math';
import 'package:flutter/material.dart';

///This is the Tile which performs animation
class LeftToRightAnimationTile extends StatelessWidget {
  final int index;
  final double value;
  final Widget child;

  const LeftToRightAnimationTile(
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
          filterQuality: FilterQuality.medium,
          alignment: Alignment.centerLeft,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.01)
            ..rotateX(value < 0.2 ? value * pi / 6 : pi / 6)
            ..translate(-80, -30, 0)
            ..setRotationZ(pi / 2 * value)
            ..translate(80, 30, 0),
          child: child,
        ),
      ),
    );
  }

}