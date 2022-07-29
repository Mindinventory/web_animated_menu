import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_hover_menu/anim/swing_menu.dart';
import 'package:flutter_web_hover_menu/anim/center_to_top_menu.dart';
import 'package:flutter_web_hover_menu/anim/left_to_right_menu.dart';
import 'package:flutter_web_hover_menu/anim/right_to_left_menu.dart';
import 'package:flutter_web_hover_menu/anim/spring_across_axis_menu.dart';
import 'package:flutter_web_hover_menu/anim/up_to_bottom_menu.dart';
import 'package:flutter_web_hover_menu/utils/animation_type.dart';

class HoverAnimationWidget extends StatefulWidget {
  ///Header properties
  final List<String> headerTiles;
  final BoxDecoration headerBoxDecoration;
  final Color headerTextColor;
  final double headerTextSize;

  ///Menu properties
  final List<String> menuTiles;
  final BoxDecoration menuBoxDecoration;
  final Color menuTextColor;
  final double menuTextSize;

  ///The type of animation
  final AnimationType animationType;

  const HoverAnimationWidget(
      {Key? key,
      required this.headerTiles,
      required this.headerBoxDecoration,
      required this.headerTextColor,
      required this.headerTextSize,
      required this.menuTiles,
      required this.menuBoxDecoration,
      required this.menuTextColor,
      required this.menuTextSize,
      required this.animationType})
      : super(key: key);

  @override
  _HoverAnimationWidgetState createState() => _HoverAnimationWidgetState();
}

class _HoverAnimationWidgetState extends State<HoverAnimationWidget>
    with SingleTickerProviderStateMixin {
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
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/common_background.jpeg',
                  fit: BoxFit.fill,
                )),
            SizedBox(
              height: 55,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.headerTiles.length,
                  shrinkWrap: false,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      child: identifyWidget(index),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  bool hovered = false;

  identifyWidget(int index) {
    if (widget.animationType == AnimationType.leftToRight) {
      return LeftToRightMenu(
        menuTiles: widget.menuTiles,
        index: index,
        hovered: hovered,
        menuBoxDecoration: widget.menuBoxDecoration,
        menuTextColor: widget.menuTextColor,
        menuTextSize: widget.menuTextSize,
        child: Container(
          width: 190,
          margin: const EdgeInsets.only(left: 10.0),
          decoration: widget.headerBoxDecoration,
          alignment: Alignment.center,
          child: Text(
            widget.headerTiles[index],
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: widget.headerTextSize,
                fontWeight: FontWeight.w500,
                color: widget.headerTextColor),
          ),
        ),
      );
    } else if (widget.animationType == AnimationType.topToBottom) {
      return TopToBottomMenu(
        menuTiles: widget.menuTiles,
        index: index,
        hovered: hovered,
        menuBoxDecoration: widget.menuBoxDecoration,
        menuTextColor: widget.menuTextColor,
        menuTextSize: widget.menuTextSize,
        child: Container(
          width: 190,
          margin: const EdgeInsets.only(left: 10.0),
          decoration: widget.headerBoxDecoration,
          alignment: Alignment.center,
          child: Text(
            widget.headerTiles[index],
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: widget.headerTextSize,
                fontWeight: FontWeight.w500,
                color: widget.headerTextColor),
          ),
        ),
      );
    } else if (widget.animationType == AnimationType.centerToTop) {
      return CenterToTopMenu(
        menuTiles: widget.menuTiles,
        index: index,
        hovered: hovered,
        menuBoxDecoration: widget.menuBoxDecoration,
        menuTextColor: widget.menuTextColor,
        menuTextSize: widget.menuTextSize,
        child: Container(
          width: 190,
          margin: const EdgeInsets.only(left: 10.0),
          decoration: widget.headerBoxDecoration,
          alignment: Alignment.center,
          child: Text(
            widget.headerTiles[index],
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: widget.headerTextSize,
                fontWeight: FontWeight.w500,
                color: widget.headerTextColor),
          ),
        ),
      );
    } else if (widget.animationType == AnimationType.rightToLeft) {
      return RightToLeftMenu(
        menuTiles: widget.menuTiles,
        index: index,
        hovered: hovered,
        menuBoxDecoration: widget.menuBoxDecoration,
        menuTextColor: widget.menuTextColor,
        menuTextSize: widget.menuTextSize,
        child: Container(
          width: 190,
          margin: const EdgeInsets.only(left: 10.0),
          decoration: widget.headerBoxDecoration,
          alignment: Alignment.center,
          child: Text(
            widget.headerTiles[index],
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: widget.headerTextSize,
                fontWeight: FontWeight.w500,
                color: widget.headerTextColor),
          ),
        ),
      );
    } else if (widget.animationType == AnimationType.springAcrossAxis) {
      return SpringAcrossAxisMenu(
        menuTiles: widget.menuTiles,
        index: index,
        hovered: hovered,
        menuBoxDecoration: widget.menuBoxDecoration,
        menuTextColor: widget.menuTextColor,
        menuTextSize: widget.menuTextSize,
        child: Container(
          width: 190,
          margin: const EdgeInsets.only(left: 10.0),
          decoration: widget.headerBoxDecoration,
          alignment: Alignment.center,
          child: Text(
            widget.headerTiles[index],
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: widget.headerTextSize,
                fontWeight: FontWeight.w500,
                color: widget.headerTextColor),
          ),
        ),
      );
    } else if (widget.animationType == AnimationType.swingAcrossAxis) {
      return SwingMenu(
        menuTiles: widget.menuTiles,
        index: index,
        hovered: hovered,
        menuBoxDecoration: widget.menuBoxDecoration,
        menuTextColor: widget.menuTextColor,
        menuTextSize: widget.menuTextSize,
        child: Container(
          width: 190,
          margin: const EdgeInsets.only(left: 10.0),
          decoration: widget.headerBoxDecoration,
          alignment: Alignment.center,
          child: Text(
            widget.headerTiles[index],
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: widget.headerTextSize,
                fontWeight: FontWeight.w500,
                color: widget.headerTextColor),
          ),
        ),
      );
    } else {
      return SwingMenu(
        menuTiles: widget.menuTiles,
        index: index,
        hovered: hovered,
        menuBoxDecoration: widget.menuBoxDecoration,
        menuTextColor: widget.menuTextColor,
        menuTextSize: widget.menuTextSize,
        child: Container(
          width: 190,
          margin: const EdgeInsets.only(left: 10.0),
          decoration: widget.headerBoxDecoration,
          alignment: Alignment.center,
          child: Text(
            widget.headerTiles[index],
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: widget.headerTextSize,
                fontWeight: FontWeight.w500,
                color: widget.headerTextColor),
          ),
        ),
      );
    }
  }
}
