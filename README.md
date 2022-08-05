# Web animated hover menu

<a href="https://flutter.dev/"><img src="https://img.shields.io/badge/flutter-website-deepskyblue.svg" alt="Flutter Website"></a>
<a href="https://dart.dev"><img src="https://img.shields.io/badge/dart-website-deepskyblue.svg" alt="Dart Website"></a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Web-deepskyblue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Mac-deepskyblue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Linux-deepskyblue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Windows-deepskyblue">
</a>
<a href=""><img src="https://app.codacy.com/project/badge/Grade/dc683c9cc61b499fa7cdbf54e4d9ff35"/></a>
<a href="https://github.com/Mindinventory/web_animated_menu/blob/master/LICENSE" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/github/license/Mindinventory/web_animated_menu"></a>
<a href="https://pub.dev/packages/web_animated_menu"><img src="https://img.shields.io/pub/v/web_animated_menu?color=as&label=web_animated_menu&logo=as1&logoColor=blue&style=social"></a>
<a href="https://github.com/Mindinventory/web_animated_menu"><img src="https://img.shields.io/github/stars/Mindinventory/web_animated_menu?style=social" alt="MIT License"></a>

A flutter package that will provide a different type of pretty animation with different alignment.

## Key Features

* Different type of animation in different alignment
* Mouse hover effect

# Existing Animations

* Left To Right 
* Right To Left
* Top To Bottom
* Bottom To Top

## Preview

![gif](https://github.com/Mindinventory/web_animated_menu/blob/main/top_right_align.gif)
![gif](https://github.com/Mindinventory/web_animated_menu/blob/main/bottom_right_align.gif)

## Easy usage

Import it to your project file

```
import 'package:web_hover_menu/web_hover_menu.dart';
```

And add it in its most basic form like it:

``` dart
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
headerPosition: HeaderPosition.bottomRight),

```

### Attributes

| prop                       | value          | required/optional | description                                  |
| -------------------------- | --------       | ----------------- | ---------------------------------------------|
| headerTiles                | array          | required          | It will provide header menu list.            |
| menuTiles                  | array          | required          | It will provide hover menu list.             |
| headerPosition             | custom         | required          | Use for header position defines menu.        |
| backgroundWidget           | Widget         | optional          | It will provide background of widget         |
| headerBoxDecoration        | style          | optional          | perticular header menu of style.             |
| headerTextColor            | color          | optional          | Use for header text color.                   |
| headerTextSize             | double         | optional          | Use for header text size.                    |
| menuBoxDecoration          | style          | optional          | Use for perticular header menu of hover menu.|
| menuTextColor              | color          | optional          | Use to  text color to hover menu.            |
| animationType              | custom         | optional          | Use for different type of animation          |
| menuTextSize               | double         | optional          | Use for text size to hover menu.             |

### Dependencies

* provider

# LICENSE!

Web Hover Animated Menu is [MIT-licensed](/LICENSE).

# Let us know!

We’d be really happy if you send us links to your projects where you use our component. Just send an
email to sales@mindinventory.com And do let us know if you have any questions or suggestion
regarding our work.
