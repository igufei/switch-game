import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Category extends StatefulWidget {
  late int categoryIndex = 0;
  final List<dynamic> categorys;
  final Function(int, int) onChanged;
  Category({
    super.key,
    required this.categoryIndex,
    required this.categorys,
    required this.onChanged,
  });

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var hoverIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        spacing: 28.0,
        runSpacing: 4.0,
        children: widget.categorys.asMap().entries.map((e) {
          int index = e.key;
          var value = e.value;
          Color bgColor = Colors.transparent;
          Color textColor = Colors.black;
          if (index == widget.categoryIndex) {
            bgColor = Get.theme.primaryColorDark;
            textColor = Colors.white;
          }
          if (index == hoverIndex) {
            bgColor = Get.theme.primaryColorDark.withOpacity(0.5);
            textColor = Colors.white;
          }
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            onHover: (event) {
              if (index == widget.categoryIndex) {
                return;
              }
              setState(() {
                hoverIndex = index;
              });
            },
            onExit: (event) {
              setState(() {
                hoverIndex = -1;
              });
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.categoryIndex = index;
                });
                widget.onChanged(index, value['ID']);
              },
              child: Container(
                padding: EdgeInsets.only(top: 2, bottom: 2, right: 5, left: 5),
                decoration: BoxDecoration(
                  color: bgColor,
                  //borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: Text(
                  value['Name'].toString(),
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
