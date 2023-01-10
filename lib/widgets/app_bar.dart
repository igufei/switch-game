import 'package:flutter/material.dart';
import 'package:switch_game/widgets/click.dart';
import 'package:switch_game/widgets/route_box.dart';
import 'package:switch_game/widgets/visible.dart';
import 'package:window_manager/window_manager.dart';

class WindowsAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final RouteController? routeController;
  const WindowsAppBar({
    super.key,
    required this.title,
    this.routeController,
  });

  @override
  Size get preferredSize => Size(double.infinity, 50);

  @override
  State<WindowsAppBar> createState() => _WindowsAppBarState();
}

class _WindowsAppBarState extends State<WindowsAppBar> {
  Color closeBtnBgColor = Colors.transparent;
  Color minBtnBgColor = Colors.transparent;
  Color closeBtnTextColor = Colors.black;
  bool showBackWidget = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Visible(
              isVisible: showBackWidget,
              child: Click(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                onClick: () {
                  widget.routeController?.back();
                },
              )),
          GestureDetector(
            onPanStart: (d) {
              windowManager.startDragging();
            },
            child: Text(
              locale: Locale('zh', 'CN'),
              widget.title,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Expanded(
              child: GestureDetector(
                  onPanStart: (d) {
                    windowManager.startDragging();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    color: Colors.transparent,
                  ))),
          Click(
            onClick: () {
              windowManager.minimize();
            },
            onHover: () {
              setState(() {
                minBtnBgColor = Colors.black12;
              });
            },
            onTapDown: () {
              setState(() {
                minBtnBgColor = Colors.black26;
              });
            },
            onExit: () {
              setState(() {
                minBtnBgColor = Colors.transparent;
              });
            },
            child: Container(
              color: minBtnBgColor,
              width: 30,
              height: 30,
              child: Icon(
                Icons.remove,
                color: Colors.black,
              ),
            ),
          ),
          Click(
            onClick: () {
              windowManager.close();
            },
            onTapDown: () {
              setState(() {
                closeBtnBgColor = Color.fromARGB(255, 188, 28, 16);
              });
            },
            onHover: () {
              setState(() {
                closeBtnBgColor = Colors.red;
                closeBtnTextColor = Colors.white;
              });
            },
            onExit: () {
              setState(() {
                closeBtnBgColor = Colors.transparent;
                closeBtnTextColor = Colors.black;
              });
            },
            child: Container(
              color: closeBtnBgColor,
              width: 30,
              height: 30,
              child: Icon(
                Icons.close,
                size: 20,
                color: closeBtnTextColor,
              ),
            ),
          ),
        ],
      ),
      elevation: 1,
      backgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    widget.routeController?.removeListener(_listener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _listener();
    widget.routeController?.addListener(_listener);
  }

  void _listener() {
    if (widget.routeController == null) {
      return;
    }
    if (widget.routeController!.views.length > 1) {
      if (mounted) {
        setState(() {
          showBackWidget = true;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          showBackWidget = false;
        });
      }
    }
  }
}
