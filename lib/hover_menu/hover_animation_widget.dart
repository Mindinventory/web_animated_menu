import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'menu_tiles_widget.dart';
import '../model/menu_model.dart';
import '../utils/animation_type.dart';
import '../utils/header_position.dart';
import '../model/header_model.dart';

class AnimatedHoverMenu extends StatefulWidget {
  ///Header properties
  final List<Menu> headerTiles;
  BoxDecoration? headerBoxDecoration;
  Color? headerTextColor;
  double? headerTextSize;

  ///Menu properties
  final List<SubMenu> menuTiles;
  BoxDecoration? menuBoxDecoration;
  Color? menuTextColor;
  double? menuTextSize;

  ///The type of animation
  AnimationType? animationType;

  ///Header menu position
  final HeaderPosition headerPosition;

  AnimatedHoverMenu({
    Key? key,
    required this.headerTiles,
    required this.menuTiles,
    required this.headerPosition,
    this.headerBoxDecoration,
    this.headerTextColor,
    this.headerTextSize,
    this.menuBoxDecoration,
    this.menuTextColor,
    this.menuTextSize,
    this.animationType,
  }) : super(key: key);

  @override
  _AnimatedHoverMenuState createState() => _AnimatedHoverMenuState();
}

class _AnimatedHoverMenuState extends State<AnimatedHoverMenu>
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
                menuBoxDecoration: widget.menuBoxDecoration ??
                    const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7.0),
                        ),
                        color: Colors.black38),
                menuTextColor: widget.menuTextColor ?? Colors.white,
                menuTextSize: widget.menuTextSize ?? 16.0,
                headerPosition: widget.headerPosition,
                animationType:
                    widget.animationType ?? AnimationType.leftToRight,
                child: Container(
                  width: 190,
                  margin: const EdgeInsets.only(left: 10.0),
                  decoration: widget.headerBoxDecoration ??
                      const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          color: Colors.black),
                  alignment: Alignment.center,
                  child: Text(
                    widget.headerTiles[index].headerName ?? '',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: widget.headerTextSize ?? 15.0,
                        fontWeight: FontWeight.w500,
                        color: widget.headerTextColor ?? Colors.white),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
