import 'package:flutter/material.dart';

///This is the Tile which performs animation
class SpringAcrossAxisAnimationTile extends StatelessWidget {
  final int index;
  final double value;
  final Widget child;

  const SpringAcrossAxisAnimationTile(
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
          alignment: Alignment.bottomCenter,
          transform: Matrix4.identity()
            ..translate(0, -10, -110)
            ..rotateY(value / 0.2)
            ..translate(0, 10, 110),
          child: child,
        ),
      ),
    );
  }

}
