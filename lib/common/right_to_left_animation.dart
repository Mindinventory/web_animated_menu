import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'scroll_event_notifier.dart';

class RightToLeftAnimation extends StatefulWidget {
  const RightToLeftAnimation({
    Key? key,
  }) : super(key: key);

  @override
  _RightToLeftAnimationState createState() =>
      _RightToLeftAnimationState();
}

class _RightToLeftAnimationState extends State<RightToLeftAnimation>
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
  void initState() {
    super.initState();

    _drawerSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _drawerSlideController.dispose();
    super.dispose();
  }

  bool _isDrawerOpen() {
    return _drawerSlideController.value == 1.0;
  }

  bool _isDrawerOpening() {
    return _drawerSlideController.status == AnimationStatus.forward;
  }

  bool _isDrawerClosed() {
    return _drawerSlideController.value == 0.0;
  }

  void _toggleDrawer() {
    if (_isDrawerOpen() || _isDrawerOpening()) {
      _drawerSlideController.reverse();
    } else {
      _drawerSlideController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00e8e8e8),
      body: MouseRegion(
        opaque: true,
        onEnter: (_) {
          setState(() {
            hovered = true;
            _toggleDrawer();
          });
        },
        onExit: (_) {
          setState(() {
            hovered = false;
            _toggleDrawer();
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
            _buildDrawer(),
          ],
        ),
      ),
    );
  }

  bool hovered = false;

  Widget _buildDrawer() {
    return AnimatedBuilder(
      animation: _drawerSlideController,
      builder: (context, child) {
        return FractionalTranslation(
          translation: const Offset(0.0, 0.0),
          child: _isDrawerClosed() ? const SizedBox() : const Menu(),
        );
      },
    );
  }

}

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

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

  @override
  void initState() {
    super.initState();

    _createAnimationIntervals();

    _staggeredController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..forward();
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
    return ChangeNotifierProvider.value(
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
    );
  }

  List<Widget> _buildListItems(ScrollEventNotifier scrollListner) {
    final listItems = <Widget>[];
    for (int i = 0; i < _menuTitles.length; ++i) {
      listItems.add(
        FutureBuilder(
            future: Future.delayed(Duration(milliseconds: (i * 50))),
            builder: (context, value) {
              if (value.connectionState == ConnectionState.done) {
                return TweenAnimationBuilder(
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 200),
                  tween: Tween<double>(begin: 1, end: 0),
                  builder: (_, double value, _child) {
                    return MenuTile(value: value, child: _child!);
                  },
                  child: InkWell(
                    onTap: (){
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
                        margin: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 10.0),
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
          ..rotateY(value < 0.2 ? value * pi : 0),
          // ..setRotationZ(value),
          // ..translate(-80, -30, 0)
          // ..setRotationZ(pi * value),
          // ..translate(80, 30, 0),
        child: child,
      ),
    );
  }
}
