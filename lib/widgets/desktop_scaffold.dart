// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:switch_game/widgets/click.dart';

class DesktopScaffold extends StatefulWidget {
  Color selectedColor;
  Color unselectedColor;
  final List<PageData> pages;
  int initIndex;
  Widget? leading;
  Widget? trailing;
  DesktopScaffold({
    super.key,
    required this.pages,
    this.initIndex = 0,
    this.leading,
    this.trailing,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.black87,
  });

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class PageData {
  final String title;
  final IconData icon;
  final Widget Function() page;

  PageData({
    required this.title,
    required this.icon,
    required this.page,
  });
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  var hoverIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            decoration: BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(255, 207, 206, 206)))),
            child: Column(children: [
              if (widget.leading != null) widget.leading!,
              SizedBox(height: 10),
              ...widget.pages.asMap().entries.map((e) {
                var btnBgColor = Colors.transparent;
                var color = widget.unselectedColor;
                if (widget.initIndex == e.key) {
                  color = widget.selectedColor;
                }
                if (hoverIndex == e.key) {
                  btnBgColor = Color.fromARGB(15, 0, 0, 0);
                } else {
                  btnBgColor = Colors.transparent;
                }
                return Click(
                  onClick: () {
                    setState(() {
                      widget.initIndex = e.key;
                    });
                  },
                  onHover: () {
                    setState(() {
                      hoverIndex = e.key;
                    });
                  },
                  onExit: () {
                    setState(() {
                      hoverIndex = -1;
                    });
                  },
                  child: Container(
                    width: 70,
                    color: btnBgColor,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      children: [
                        Icon(
                          e.value.icon,
                          color: color,
                          size: 25,
                        ),
                        SizedBox(height: 2),
                        Text(
                          e.value.title,
                          style: TextStyle(
                            color: color,
                          ),
                          locale: Locale('zh', 'CN'),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              Spacer(),
              if (widget.trailing != null) widget.trailing!,
            ]),
          ),
          Expanded(
              child: IndexedStack(
            index: widget.initIndex,
            children: widget.pages.map((e) {
              return e.page.call();
            }).toList(),
          ))
        ],
      ),
    );
  }
}
