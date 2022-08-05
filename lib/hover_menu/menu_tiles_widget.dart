import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../anim/center_to_top_animation_tile.dart';
import '../anim/right_to_left_animation_tile.dart';
import '../anim/spring_across_axis_animation_tile.dart';
import '../anim/swing_across_axis_animation_tile.dart';
import '../anim/top_to_bottom_animation_tile.dart';
import '../model/menu.dart';
import '../model/sub_menu.dart';
import '../utils/animation_type.dart';
import '../utils/header_position.dart';
import '../anim/left_to_right_animation_tile.dart';
import '../hover_menu/scroll_event_notifier.dart';

class MenuTilesWidget extends StatefulWidget {
  final Widget child;
  final int index;
  final bool hovered;
  final List<SubMenu> menuTiles;
  final List<Menu> headerTiles;
  final BoxDecoration menuBoxDecoration;
  final Color menuTextColor;
  final double menuTextSize;
  final HeaderPosition headerPosition;
  final AnimationType animationType;

  const MenuTilesWidget({
    Key? key,
    required this.menuTiles,
    required this.headerTiles,
    required this.child,
    required this.index,
    required this.hovered,
    required this.menuBoxDecoration,
    required this.menuTextColor,
    required this.menuTextSize,
    required this.headerPosition,
    required this.animationType,
  }) : super(key: key);

  @override
  _MenuTilesWidgetState createState() => _MenuTilesWidgetState();
}

class _MenuTilesWidgetState extends State<MenuTilesWidget>
    with SingleTickerProviderStateMixin {
  final GlobalKey _globalKey = GlobalKey();
  OverlayEntry? entry;
  List _menuHover = [];
  ScrollController controller = ScrollController();
  bool allowAddEntry = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _menuHover = List.filled(widget.headerTiles.length, false);
      entry = _overlayEntry();
      entry?.addListener(() {
        allowAddEntry = !allowAddEntry;
      });
    });
  }

  ///Mouse region of header and perform animation according to it
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: true,
      onHover: (_) {
        if (allowAddEntry && !_menuHover[widget.index]) {
          _menuHover[widget.index] = true;
          _addOverlay(entry!);
        }
      },
      onExit: (_) {
        _menuHover[widget.index] = false;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (!_menuHover[widget.index] && entry != null) {
            if (!entry!.mounted) {
              return;
            } else {
              entry?.remove();
            }
          }
        });
      },
      child: Container(
        key: _globalKey,
        child: widget.child,
      ),
    );
  }

  ///Adding overlay entry
  OverlayEntry _overlayEntry() {
    return OverlayEntry(builder: (BuildContext overlayContext) {
      final offset = _getPosition();
      return Positioned(
        top: (widget.headerPosition == HeaderPosition.bottomLeft ||
                widget.headerPosition == HeaderPosition.bottomRight)
            ? null
            : 50,
        bottom: (widget.headerPosition == HeaderPosition.bottomLeft ||
                widget.headerPosition == HeaderPosition.bottomRight)
            ? 50
            : null,
        left: offset.dx + 5,
        child: ChangeNotifierProvider.value(
          value: ScrollEventNotifier(false, false),
          child: StatefulBuilder(
            builder: (context, setStateForOverlay) {
              return Material(
                color: Colors.transparent,
                child: MouseRegion(
                  onEnter: (_) {
                    if (!_menuHover[widget.index]) {
                      _menuHover[widget.index] = true;
                    }
                  },
                  onExit: (_) {
                    if (_menuHover[widget.index]) {
                      _menuHover[widget.index] = false;
                      setStateForOverlay(() {});
                    }
                  },
                  child: SizedBox(
                    height: 400,
                    child: SingleChildScrollView(
                      controller: controller,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: _buildListItems(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  ///Get position according to hover position
  Offset _getPosition() {
    final renderBox =
        _globalKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.localToGlobal(Offset.zero);
  }

  ///Showing list with using curve and delay
  List<Widget> _buildListItems() {
    final listItems = <Widget>[];
    for (int i = 0; i < widget.menuTiles.length; ++i) {
      listItems.add(
        FutureBuilder(
            future: Future.delayed(Duration(milliseconds: (i * 200))),
            builder: (context, value) {
              if (value.connectionState == ConnectionState.done) {
                return TweenAnimationBuilder(
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 200),
                  onEnd: () {
                    if (entry != null && !_menuHover[widget.index]) {
                      if (!entry!.mounted) {
                        return;
                      } else {
                        entry!.remove();
                      }
                    }
                  },
                  tween: _menuHover[widget.index]
                      ? Tween<double>(begin: 1, end: 0)
                      : Tween<double>(begin: 0, end: 1),
                  builder: (_, double value, _child) {
                    return _defineAnimationType(
                        widget.animationType, value, _child, i);
                  },
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("You Tapped On ${widget.menuTiles[i]}"),
                          duration: const Duration(milliseconds: 500)));
                    },
                    child: SizedBox(
                      width: 200,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: widget.menuBoxDecoration,
                        margin: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            widget.menuTiles[i].name ?? '',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: widget.menuTextSize,
                                fontWeight: FontWeight.w500,
                                color: widget.menuTextColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Container();
            }),
      );
    }
    return listItems;
  }

  ///Add overlay using it's entry
  _addOverlay(OverlayEntry entry) {
    Overlay.of(context)?.insert(entry);
  }

  ///According to animation type returning different type of Tile with animation
  Widget _defineAnimationType(AnimationType animationType, double value, Widget? child, int i) {
    if (animationType == AnimationType.rightToLeft) {
      return RightToLeftAnimationTile(
        value: value,
        index: i,
        child: child!,
      );
    } else if (animationType == AnimationType.leftToRight) {
      return LeftToRightAnimationTile(
        value: value,
        index: i,
        child: child!,
      );
    } else if (animationType == AnimationType.topToBottom) {
      return TopToBottomAnimationTile(
        value: value,
        index: i,
        child: child!,
      );
    } else if (animationType == AnimationType.centerToTop) {
      return CenterTopAnimationTile(
        value: value,
        index: i,
        child: child!,
      );
    } else if (animationType == AnimationType.springAcrossAxis) {
      return SpringAcrossAxisAnimationTile(
        value: value,
        index: i,
        child: child!,
      );
    } else if (animationType == AnimationType.swingAcrossAxis) {
      return SwingAcrossAxisAnimationTile(
        value: value,
        index: i,
        child: child!,
      );
    } else {
      return LeftToRightAnimationTile(
        value: value,
        index: i,
        child: child!,
      );
    }
  }
}
