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
    Menu(headerId: 1, headerName: 'Home'),
    Menu(headerId: 2, headerName: 'Profile'),
    Menu(headerId: 3, headerName: 'Help'),
    Menu(headerId: 4, headerName: 'Contact Us'),
    Menu(headerId: 5, headerName: 'About Us'),
    Menu(headerId: 6, headerName: 'Home'),
    Menu(headerId: 7, headerName: 'Profile'),
    Menu(headerId: 8, headerName: 'Help'),
    Menu(headerId: 9, headerName: 'Contact Us'),
    Menu(headerId: 5, headerName: 'About Us'),
  }.toList();

  List<SubMenu> menuModelList = {
    SubMenu(menuId: 1, menuName: 'Declarative style'),
    SubMenu(menuId: 2, menuName: 'Premade common'),
    SubMenu(menuId: 3, menuName: 'Stateful hot reload'),
    SubMenu(menuId: 4, menuName: 'Native performance'),
    SubMenu(menuId: 5, menuName: 'Great community'),
    SubMenu(menuId: 1, menuName: 'Declarative style'),
    SubMenu(menuId: 2, menuName: 'Premade common'),
    SubMenu(menuId: 3, menuName: 'Stateful hot reload'),
    SubMenu(menuId: 4, menuName: 'Native performance'),
    SubMenu(menuId: 5, menuName: 'Great community'),
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
        AnimatedHoverMenu(
          headerTiles: headerModelList,
          menuTiles: menuModelList,
          headerPosition: HeaderPosition.topLeft,
          headerBoxDecoration: null,
          headerTextColor: null,
          headerTextSize: null,
          menuBoxDecoration: null,
          menuTextColor: null,
          animationType: null,
          menuTextSize: null,
        ),
      ],

    );
  }
}
