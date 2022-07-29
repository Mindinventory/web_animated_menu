import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../hover_menu/scroll_event_notifier.dart';

class CenterToTopMenu extends StatefulWidget {
  final Widget child;
  final int index;
  final bool hovered;
  final List<String> menuTiles;
  final BoxDecoration menuBoxDecoration;
  final Color menuTextColor;
  final double menuTextSize;

  const CenterToTopMenu({
    Key? key,
    required this.menuTiles,
    required this.child,
    required this.index,
    required this.hovered,
    required this.menuBoxDecoration,
    required this.menuTextColor,
    required this.menuTextSize,
  }) : super(key: key);

  @override
  _CenterToTopMenuState createState() => _CenterToTopMenuState();
}

class _CenterToTopMenuState extends State<CenterToTopMenu> with SingleTickerProviderStateMixin {

  final GlobalKey _globalKey = GlobalKey();
  OverlayEntry? entry;
  final _menuHover = List.filled(5, false);
  ScrollController controller = ScrollController();
  bool allowAddEntry = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      entry = overlayEntry();
      entry?.addListener(() {
        allowAddEntry = !allowAddEntry;
      });
    });
  }

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
  overlayEntry() {
    return OverlayEntry(builder: (BuildContext overlayContext) {
      final offset = _getPosition();
      return Positioned(
        top: offset.dy + 50,
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
                      physics:  const AlwaysScrollableScrollPhysics(),
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
                    return CenterToUpAnimationTile(
                      value: value,
                      child: _child!,
                      index: i,
                    );
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
                            widget.menuTiles[i],
                            textAlign: TextAlign.left,
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
  void _addOverlay(OverlayEntry entry) {
    Overlay.of(context)?.insert(entry);
  }
}

///This widget will provide perticular tile with animation
class CenterToUpAnimationTile extends StatelessWidget {
  final int index;
  final double value;
  final Widget child;

  const CenterToUpAnimationTile(
      {Key? key, required this.value, required this.child, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: index == 0
          ? const EdgeInsets.only(top: 10)
          : const EdgeInsets.only(top: 0),
      child: Opacity(
        opacity: 1 - value,
        child: Transform(
          filterQuality: FilterQuality.medium,
          alignment: Alignment.centerLeft,
          transform: Matrix4.identity()
            ..translate(-30, 0, 0)
            ..rotateX(value / 0.5)
            ..translate(30, 0, 0),
          child: child,
        ),
      ),
    );
  }
}
