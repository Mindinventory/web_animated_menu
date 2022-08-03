import 'package:flutter/material.dart';
import 'hover_animation_widget.dart';
import '../model/header_model.dart';
import '../model/menu_model.dart';
import '../utils/animation_type.dart';
import '../utils/header_position.dart';

///Your app of entry point where you define Animation type , Customize menu and header
class EntryPointApp extends StatefulWidget {
  const EntryPointApp({Key? key}) : super(key: key);

  @override
  State<EntryPointApp> createState() => _EntryPointAppState();
}

class _EntryPointAppState extends State<EntryPointApp> {
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
    return HoverAnimationWidget(
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
