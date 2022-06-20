import 'package:flutter/material.dart';
import 'package:flutter_web_hover_menu/common/bottom_to_up_animation.dart';
import 'package:flutter_web_hover_menu/common/left_to_right_animation.dart';
import 'package:flutter_web_hover_menu/common/right_to_left_animation.dart';
import 'package:flutter_web_hover_menu/utils/animation_type.dart';

class EntryPointApp extends StatefulWidget {
  String? type;

  EntryPointApp(this.type, {Key? key}) : super(key: key);

  @override
  State<EntryPointApp> createState() => _EntryPointAppState();
}

class _EntryPointAppState extends State<EntryPointApp> {
  static const headerTiles = [
    'Home',
    'Profile',
    'Help',
    'Contact Us',
    'About Us'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: defineWidgetFromType(),
    );
  }

  defineWidgetFromType() {
    if (widget.type == AnimationType.leftToRight) {
      return  LeftToRightAnimation( headerTiles: headerTiles,);
    } else if (widget.type == AnimationType.rightToLeft) {
      return const RightToLeftAnimation();
    } else if (widget.type == AnimationType.bottomToUp) {
      return const BottomToUpAnimation();
    } else {
      return  LeftToRightAnimation(headerTiles: headerTiles,);
    }
  }

}
