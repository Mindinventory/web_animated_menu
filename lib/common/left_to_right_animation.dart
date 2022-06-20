import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'scroll_event_notifier.dart';

class LeftToRightAnimation extends StatefulWidget {
  List<String> headerTiles;

  LeftToRightAnimation({Key? key, required this.headerTiles}) : super(key: key);

  @override
  _LeftToRightAnimationState createState() => _LeftToRightAnimationState();
}

class _LeftToRightAnimationState extends State<LeftToRightAnimation>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: MouseRegion(
        opaque: true,
        onEnter: (_) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            hovered = false;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.headerTiles.length,
                  shrinkWrap: false,
                  itemBuilder: (context, index) {
                    return Menu(
                      index: index,
                      hovered: hovered,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        width: 210,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            color: Colors.black),
                        alignment: Alignment.center,
                        child: Text(
                          widget.headerTiles[index],
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  bool hovered = false;
}

class Menu extends StatefulWidget {
  final Widget child;
  final int index;
  final bool hovered;

  const Menu(
      {Key? key,
      required this.child,
      required this.index,
      required this.hovered})
      : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  final GlobalKey _globalKey = GlobalKey();
  OverlayEntry? entry;

  static const _menuTitles = [
    'Declarative style',
    'Premade common',
    'Stateful hot reload',
    'Native performance',
    'Great community',
  ];

  final _menuHover = List.filled(5, false);
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      entry = OverlayEntry(builder: (BuildContext overlayContext) {
        final offset = _getPosition();
        return Positioned(
          top: offset.dy + 50,
          left: offset.dx + 5,
          child: ChangeNotifierProvider.value(
            value: ScrollEventNotifier(false, false),
            child: StatefulBuilder(
              builder: (context, setStateForOverlay) {
                var scrollListener = Provider.of<ScrollEventNotifier>(context);

                return NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollStartNotification) {
                        scrollListener.isScrolling = true;
                      } else if (notification is ScrollEndNotification) {
                        scrollListener.isScrolling = false;
                      }
                      if (controller.position.userScrollDirection ==
                          ScrollDirection.reverse) {
                        scrollListener.isReverseScrolling = false;
                      } else if (controller.position.userScrollDirection ==
                          ScrollDirection.forward) {
                        scrollListener.isReverseScrolling = true;
                      }
                      return true;
                    },
                    child: Material(
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              ..._buildListItems(scrollListener),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: MouseRegion(
        opaque: true,
        onEnter: (_) {
          if (!_menuHover[widget.index]) {
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
                entry!.remove();
              }
            }
          });
        },
        child: Container(
          key: _globalKey,
          child: widget.child,
        ),
      ),
    );
  }

  Offset _getPosition() {
    final renderBox =
        _globalKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.localToGlobal(Offset.zero);
  }

  List<Widget> _buildListItems(ScrollEventNotifier scrollListner) {
    final listItems = <Widget>[];
    for (int i = 0; i < _menuTitles.length; ++i) {
      listItems.add(
        FutureBuilder(
            future: Future.delayed(Duration(milliseconds: (i * 200))),
            builder: (context, value) {
              if (value.connectionState == ConnectionState.done) {
                return TweenAnimationBuilder(
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 200),
                  onEnd: () {
                    if (!_menuHover[widget.index] && entry != null) {
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
                    return MenuTile(value: value, child: _child!);
                  },
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Your mouse hover on ${_menuTitles[i]}"),
                          duration: const Duration(milliseconds: 500)));
                    },
                    child: SizedBox(
                      width: 200,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0)),
                            color: Colors.yellow.shade600),
                        margin: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _menuTitles[i],
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
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

  void _addOverlay(OverlayEntry entry) async {
    Overlay.of(context)!.insert(entry);
  }
}

class MenuTile extends StatelessWidget {
  final double value;
  final Widget child;

  const MenuTile({Key? key, required this.value, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1 - value,
      child: Transform(
        filterQuality: FilterQuality.medium,
        alignment: Alignment.centerLeft,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.01)
          ..rotateX(value < 0.2 ? value * pi / 6 : pi / 6)
          ..translate(-80, -30, 0)
          ..setRotationZ(pi / 2 * value)
          ..translate(80, 30, 0),
        child: child,
      ),
    );
  }
}
