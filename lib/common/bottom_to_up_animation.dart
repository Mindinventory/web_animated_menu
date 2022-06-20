import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'scroll_event_notifier.dart';

class BottomToUpAnimation extends StatefulWidget {
  const BottomToUpAnimation({
    Key? key,
  }) : super(key: key);

  @override
  _BottomToUpAnimationState createState() => _BottomToUpAnimationState();
}

class _BottomToUpAnimationState extends State<BottomToUpAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _drawerSlideController;
  static const _navTiles = [
    'Home',
    'Profile',
    'Help',
    'Contact Us',
    'About Us'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00e8e8e8),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _navTiles.length,
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    width: 210,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Colors.black),
                    alignment: Alignment.center,
                    child: Text(
                      _navTiles[index],
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

}

class Menu extends StatefulWidget {
  final Widget child;
  final int index;

  const Menu({Key? key, required this.child, required this.index})
      : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  static const _menuTitles = [
    'Declarative style',
    'Premade common',
    'Stateful hot reload',
    'Native performance',
    'Great community',
  ];

  static const _initialDelayTime = Duration(milliseconds: 50);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 500);
  final _animationDuration = _initialDelayTime +
      (_staggerTime * _menuTitles.length) +
      _buttonDelayTime +
      _buttonTime;

  late AnimationController _staggeredController;
  final List<Interval> _itemSlideIntervals = [];
  ScrollController controller = ScrollController();
  late final OverlayEntry entry;
  final GlobalKey _globalKey = GlobalKey();
  final _menuHover = List.filled(5, false);

  @override
  void initState() {
    super.initState();

    _createAnimationIntervals();

    entry = OverlayEntry(builder: (BuildContext overlayContext) {
      final offset = _getPosition();
      return Positioned(
        top: offset.dy + 100,
        left: offset.dx + 5,
        child: ChangeNotifierProvider.value(
          value: ScrollEventNotifier(false, false),
          child: Builder(
            builder: (context) {
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
                  child: Container(
                    color: Colors.white,
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
                  ));
            },
          ),
        ),
      );
    });
  }

  Offset _getPosition() {
    final renderBox =
        _globalKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.localToGlobal(Offset.zero);
  }

  void _addOverlay(OverlayEntry entry) async {
    Overlay.of(context)!.insert(entry);
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < _menuTitles.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(
        Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
        ),
      );
    }
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
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
            _addOverlay(entry);
          }
        },
        onExit: (_) {
          if (_menuHover[widget.index]) {
            _menuHover[widget.index] = false;
            Future.delayed(const Duration(milliseconds: 100), () {
              if (!_menuHover[widget.index]) {
                entry.remove();
              }
            });
          }
        },
        child: Container(
          key: _globalKey,
          child: widget.child,
        ),
      ),
    );
  }

  List<Widget> _buildListItems(ScrollEventNotifier scrollListner) {
    final listItems = <Widget>[];
    for (int i = 0; i < _menuTitles.length; i++) {
      addFutureBuilder(listItems, i);
    }
    return listItems;
  }

  void addFutureBuilder(List listItems, int i) {
    listItems.add(FutureBuilder(
        future: Future.delayed(Duration(
            milliseconds: _menuHover[widget.index]
                ? i
                : (_menuTitles.length - i - 1) * 200)),
        builder: (context, value) {
          if (value.connectionState == ConnectionState.done) {
            return TweenAnimationBuilder(
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 2000),
              tween: _menuHover[widget.index]
                  ? Tween<double>(begin: 1, end: 0)
                  : Tween<double>(begin: 0, end: 1),
              builder: (_, double value, _child) {
                return MenuTile(value: value, child: _child!);
              },
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Your mouse hover on ${_menuTitles[i]}"),
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
        }));
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
          ..rotateY(value < 0.2 ? value * (-pi / 2) : pi / 6)
          ..setRotationZ((pi / 2) * value),
        child: child,
      ),
    );
  }
}
