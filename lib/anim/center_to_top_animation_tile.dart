import 'package:flutter/material.dart';

///This is the Tile which performs animation
class CenterTopAnimationTile extends StatelessWidget {
  final int index;
  final double value;
  final Widget child;

  const CenterTopAnimationTile(
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
            ..translate(-30, 0, 0)
            ..rotateX(value / 0.5)
            ..translate(30, 0, 0),
          child: child,
        ),
      ),
    );
  }
}
