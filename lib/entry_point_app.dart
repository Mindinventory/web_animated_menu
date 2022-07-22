import 'package:flutter/material.dart';
import 'package:flutter_web_hover_menu/common/left_to_right_animation.dart';

///Your app of entry point where you define
class EntryPointApp extends StatefulWidget {
  const EntryPointApp({Key? key}) : super(key: key);

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

  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LeftToRightAnimation(
        headerTiles: headerTiles,
      ),
    );
  }
}
