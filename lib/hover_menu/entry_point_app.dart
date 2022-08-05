import 'package:flutter/material.dart';
import 'hover_animation_widget.dart';
import '../model/menu.dart';
import '../model/sub_menu.dart';
import '../utils/animation_type.dart';
import '../utils/header_position.dart';

///Your app of entry point where you define Animation type , Customize menu and header
class EntryPointApp extends StatefulWidget {
  const EntryPointApp({Key? key}) : super(key: key);

  @override
  State<EntryPointApp> createState() => _EntryPointAppState();
}

class _EntryPointAppState extends State<EntryPointApp> {
  List<Menu> headerModelList = {
    Menu(headerId: 1, headerName: 'Home'),
    Menu(headerId: 2, headerName: 'Profile'),
    Menu(headerId: 3, headerName: 'Help'),
    Menu(headerId: 4, headerName: 'Contact Us'),
    Menu(headerId: 5, headerName: 'About Us')
  }.toList();

  List<SubMenu> menuModelList = {
    SubMenu(menuId: 1, menuName: 'Declarative style'),
    SubMenu(menuId: 2, menuName: 'Premade common'),
    SubMenu(menuId: 3, menuName: 'Stateful hot reload'),
    SubMenu(menuId: 4, menuName: 'Native performance'),
    SubMenu(menuId: 5, menuName: 'Great community')
  }.toList();

  @override
  Widget build(BuildContext context) {
    return AnimatedHoverMenu(
      headerPosition: HeaderPosition.topLeft,
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
      animationType: AnimationType.leftToRight,
      menuTextSize: 16.0,
    );
  }
}
