import 'package:flutter/material.dart';
import 'package:flutter_web_hover_menu/entry_point_app.dart';
import 'package:flutter_web_hover_menu/utils/animation_type.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EntryPointApp(AnimationType.leftToRight),
    );
  }
}



