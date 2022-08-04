import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'menu_tiles_widget.dart';
import '../model/menu_model.dart';
import '../utils/animation_type.dart';
import '../utils/header_position.dart';
import '../model/header_model.dart';

class HoverAnimationWidget extends StatefulWidget {
  ///Header properties
  final List<HeaderModel> headerTiles;
  final BoxDecoration headerBoxDecoration;
  final Color headerTextColor;
  final double headerTextSize;

  ///Menu properties
  final List<MenuModel> menuTiles;
  final BoxDecoration menuBoxDecoration;
  final Color menuTextColor;
  final double menuTextSize;

  ///The type of animation
  final AnimationType animationType;

  ///Header menu position
  final HeaderPosition headerPosition;

  const HoverAnimationWidget({
    Key? key,
    required this.headerPosition,
    required this.headerTiles,
    required this.headerBoxDecoration,
    required this.headerTextColor,
    required this.headerTextSize,
    required this.menuTiles,
    required this.menuBoxDecoration,
    required this.menuTextColor,
    required this.menuTextSize,
    required this.animationType,
  }) : super(key: key);

  @override
  _HoverAnimationWidgetState createState() => _HoverAnimationWidgetState();
}

class _HoverAnimationWidgetState extends State<HoverAnimationWidget>
    with SingleTickerProviderStateMixin {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: MouseRegion(
        opaque: true,
        onEnter: (PointerEnterEvent pointerEnterEvent) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (PointerExitEvent pointerExitEvent) {
          setState(() {
            hovered = false;
          });
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/common_background.jpeg',
                  fit: BoxFit.fill,
                )),
            _defineHeaderPosition(widget.headerPosition),
          ],
        ),
      ),
    );
  }

  ///Here we are bifurcating animation type and according to that we have set it's alignment
  Widget _defineHeaderPosition(HeaderPosition headerPosition) {
    if (headerPosition == HeaderPosition.topLeft) {
      return _headerMenuWidget();
    } else if (headerPosition == HeaderPosition.bottomLeft) {
      return Container(
        alignment: Alignment.bottomLeft,
        child: _headerMenuWidget(),
      );
    } else if (headerPosition == HeaderPosition.topRight) {
      return _headerMenuWidget();
    } else if (headerPosition == HeaderPosition.bottomRight) {
      return Container(
        alignment: Alignment.bottomRight,
        child: _headerMenuWidget(),
      );
    } else {
      return const Offstage();
    }
  }

  ///It will return header menu list
  Widget _headerMenuWidget() {
    return SizedBox(
      height: 55,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.headerTiles.length,
          shrinkWrap:
              widget.headerPosition == HeaderPosition.topLeft ? false : true,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(8.0),
              child: MenuTilesWidget(
                menuTiles: widget.menuTiles,
                headerTiles: widget.headerTiles,
                index: index,
                hovered: hovered,
                menuBoxDecoration: widget.menuBoxDecoration,
                menuTextColor: widget.menuTextColor,
                menuTextSize: widget.menuTextSize,
                headerPosition: widget.headerPosition,
                animationType: widget.animationType,
                child: Container(
                  width: 190,
                  margin: const EdgeInsets.only(left: 10.0),
                  decoration: widget.headerBoxDecoration,
                  alignment: Alignment.center,
                  child: Text(
                    widget.headerTiles[index].headerName ?? '',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: widget.headerTextSize,
                        fontWeight: FontWeight.w500,
                        color: widget.headerTextColor),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
