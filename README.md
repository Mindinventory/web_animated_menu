# Web animated hover menu

A flutter package that will provide a different type of pretty animation with different alignment.

## Preview

![gif](https://git.mindinventory.com/github/web_animated_menu_flutter/blob/development/bottom_left_align.gif)  ![gif](https://github.com/Mindinventory/web_hover_menu/blob/development/bottom_right_align.gif)   ![gif](https://github.com/Mindinventory/web_hover_menu/blob/development/top_left_align.gif) ![gif](https://github.com/Mindinventory/web_hover_menu/blob/development/top_right_align.gif)

## Key Features

* Different type of animation in different alignment
* Mouse hover effect

## Easy usage

* Step 1:- To use this package, add `web_hover_menu ` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

    ```yaml
        dependencies:
          ...
          web_animated_hover_menu: ^0.0.1
    ```

* Step 2:- Add `web_hover_menu` in your dart file

  ```
        import 'package:web_hover_menu/web_hover_menu.dart';
  
        ...
        
             child:  HoverAnimationWidget(
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
  
  ```
    
### Attributes

`headerTiles` : header menu list \
`headerBoxDecoration` : perticular header menu of style \
`headerTextColor` : header text color \
`headerTextSize` : header text size \
`menuTiles` : hover menu list \
`menuBoxDecoration` : perticular header menu of hover menu \
`menuTextColor` : text color to hover menu \
`animationType` : different type of animation Review 'AnimationType' \
`menuTextSize` : text size to hover menu \
`headerPosition` : header position defines menu of alignment (position ex: topLeft,topRight) For more Review HeaderPosition

### Dependencies

* provider

# LICENSE!

Web Hover Animated Menu is [MIT-licensed](/LICENSE).

# Let us know!

We’d be really happy if you send us links to your projects where you use our component. Just send an email to sales@mindinventory.com And do let us know if you have any questions or suggestion regarding our work.