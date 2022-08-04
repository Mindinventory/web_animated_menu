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
  List<HeaderModel> headerModelList = {
    HeaderModel(headerId: 1, headerName: 'Home'),
    HeaderModel(headerId: 2, headerName: 'Profile'),
    HeaderModel(headerId: 3, headerName: 'Help'),
    HeaderModel(headerId: 4, headerName: 'Contact Us'),
    HeaderModel(headerId: 5, headerName: 'About Us'),
    HeaderModel(headerId: 6, headerName: 'Home'),
    HeaderModel(headerId: 7, headerName: 'Profile'),
    HeaderModel(headerId: 8, headerName: 'Help'),
    HeaderModel(headerId: 9, headerName: 'Contact Us'),
    HeaderModel(headerId: 5, headerName: 'About Us'),
  }.toList();

  List<MenuModel> menuModelList = {
    MenuModel(menuId: 1, menuName: 'Declarative style'),
    MenuModel(menuId: 2, menuName: 'Premade common'),
    MenuModel(menuId: 3, menuName: 'Stateful hot reload'),
    MenuModel(menuId: 4, menuName: 'Native performance'),
    MenuModel(menuId: 5, menuName: 'Great community'),
    MenuModel(menuId: 1, menuName: 'Declarative style'),
    MenuModel(menuId: 2, menuName: 'Premade common'),
    MenuModel(menuId: 3, menuName: 'Stateful hot reload'),
    MenuModel(menuId: 4, menuName: 'Native performance'),
    MenuModel(menuId: 5, menuName: 'Great community'),
  }.toList();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/common_background.jpeg',
              fit: BoxFit.fill,
            )),
        HoverAnimationWidget(
          headerTiles: headerModelList,
          headerBoxDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              color: Colors.black),
          headerTextColor: Colors.white,
          headerTextSize: 15.0,
          menuTiles: menuModelList,
          menuBoxDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(7.0),
              ),
              color: Colors.black38),
          menuTextColor: Colors.white,
          animationType: AnimationType.rightToLeft,
          menuTextSize: 16.0,
          headerPosition: HeaderPosition.bottomRight,
        ),
      ],
    );
  }
}
