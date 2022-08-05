import 'package:flutter/material.dart';
import 'package:web_hover_menu/web_hover_menu.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Web animated hover menu',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Menu> headerModelList = {
    Menu(id: 1, name: 'Home'),
    Menu(id: 2, name: 'Profile'),
    Menu(id: 3, name: 'Help'),
    Menu(id: 4, name: 'Contact Us'),
    Menu(id: 5, name: 'About Us')
  }.toList();

  List<SubMenu> menuModelList = {
    SubMenu(id: 1, name: 'Declarative style'),
    SubMenu(id: 2, name: 'Premade common'),
    SubMenu(id: 3, name: 'Stateful hot reload'),
    SubMenu(id: 4, name: 'Native performance'),
    SubMenu(id: 5, name: 'Great community')
  }.toList();

  @override
  Widget build(BuildContext context) {
    return AnimatedHoverMenu(
      headerPosition: HeaderPosition.bottomRight,
      headerTiles: headerModelList,
      menuTiles: menuModelList,
      backgroundWidget: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xfffff8f9),
              Color(0xfffef7f8),
              Color(0xffecf0fa),
            ],
          ),
        ),
      ),
      headerBoxDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          color: Color(0xff996617)),
      headerTextColor: Colors.white,
      headerTextSize: 15.0,
      menuBoxDecoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(color: Color(0xff996617), width: 2),
        ),
      ),
      menuTextColor: Color(0xff996617),
      animationType: AnimationType.springAcrossAxis,
      menuTextSize: 16.0,
    );
  }
}
