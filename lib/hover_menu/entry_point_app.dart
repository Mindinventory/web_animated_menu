import 'package:flutter/material.dart';
import 'package:flutter_web_hover_menu/hover_menu/hover_animation_widget.dart';
import 'package:flutter_web_hover_menu/utils/animation_type.dart';

///Your app of entry point where you define Animation type , Customize menu and header
class EntryPointApp extends StatefulWidget {
  const EntryPointApp({Key? key}) : super(key: key);

  @override
  State<EntryPointApp> createState() => _EntryPointAppState();
}

class _EntryPointAppState extends State<EntryPointApp> {
  ///Heading titles
  static const headerTitles = [
    'Home',
    'Profile',
    'Help',
    'Contact Us',
    'About Us'
  ];

  ///Menu titles
  static const menuTitles = [
    'Declarative style',
    'Premade common',
    'Stateful hot reload',
    'Native performance',
    'Great community',
  ];

  @override
  Widget build(BuildContext context) {
    return const HoverAnimationWidget(
      headerTiles: headerTitles,
      headerBoxDecoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          color: Colors.black),
      headerTextColor: Colors.white,
      headerTextSize: 15.0,
      menuTiles: menuTitles,
      menuBoxDecoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
          color: Colors.black38),
      menuTextColor: Colors.white,
      animationType: AnimationType.swingAcrossAxis,
      menuTextSize: 16.0,
    );
  }
}
