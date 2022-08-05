# Web animated hover menu

A flutter package that will provide a different type of pretty animation with different alignment.

## Key Features

* Different type of animation in different alignment
* Mouse hover effect

## Preview

![gif](https://github.com/Mindinventory/web_animated_menu/blob/main/top_left_align.gif)
![gif](https://github.com/Mindinventory/web_animated_menu/blob/main/top_right_align.gif)
![gif](https://github.com/Mindinventory/web_animated_menu/blob/main/bottom_left_align.gif)  
![gif](https://github.com/Mindinventory/web_animated_menu/blob/main/bottom_right_align.gif)   

## Easy usage

* Step 1:- To use this package, add `web_animated_hover_menu ` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

    ```yaml
        dependencies:
          ...
          web_animated_hover_menu: ^0.0.1
    ```

* Step 2:- Add `web_hover_menu` in your dart file

  ``` dart
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

| prop                       | value    | required/optional | description                                  |
| -------------------------- | -------- | ----------------- | ---------------------------------------------|
| headerTiles                | array    | required          | It will provide header menu list.            |
| menuTiles                  | array    | required          | It will provide hover menu list.             |
| headerPosition             | custom   | required          | Use for header position defines menu.        |
| headerBoxDecoration        | style    | optional          | perticular header menu of style.             |
| headerTextColor            | color    | optional          | Use for header text color.                   |
| headerTextSize             | double   | optional          | Use for header text size.                    |
| menuBoxDecoration          | style    | optional          | Use for perticular header menu of hover menu.|
| menuTextColor              | color    | optional          | Use to  text color to hover menu.            |
| animationType              | custom   | optional          | Use for different type of animation          |
| menuTextSize               | double   | optional          | Use for text size to hover menu.             |

### Dependencies

* provider

# LICENSE!

Web Hover Animated Menu is [MIT-licensed](/LICENSE).

# Let us know!

We’d be really happy if you send us links to your projects where you use our component. Just send an email to sales@mindinventory.com And do let us know if you have any questions or suggestion regarding our work.