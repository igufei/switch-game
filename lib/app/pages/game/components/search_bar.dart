import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:switch_game/app/pages/game/controllers/game_controller.dart';
import 'package:switch_game/widgets/my_button.dart';

class SearchBar extends GetView<GameController> {
  final dynamic Function() onSearched;
  final dynamic Function() onNextPage;
  final dynamic Function() onPreviousPage;
  final FocusNode _fn = FocusNode();
  SearchBar({
    super.key,
    required this.onSearched,
    required this.onNextPage,
    required this.onPreviousPage,
  }) {
    _fn.onKey = ((node, event) {
      if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
        onSearched();
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          height: 27,
          child: TextField(
            focusNode: _fn,
            controller: controller.gameNameC,
            cursorHeight: 18,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              isDense: false,
              prefixIcon: Container(
                padding: const EdgeInsets.only(left: 5, right: 4),
                //color: Colors.red,
                child: Icon(
                  Icons.search,
                  size: 17,
                  color: Get.theme.primaryColorDark,
                ),
              ),
              prefixIconConstraints: BoxConstraints(minHeight: 17, minWidth: 17),
              hintText: '请输入游戏名称',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Get.theme.primaryColorDark,
                  width: 1,
                ),
                borderRadius: BorderRadius.zero,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Get.theme.primaryColorDark,
                  width: 1,
                ),
                borderRadius: BorderRadius.zero,
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Get.theme.primaryColorDark,
                  width: 1,
                ),
                borderRadius: BorderRadius.zero,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Get.theme.primaryColorDark,
                  width: 1,
                ),
                borderRadius: BorderRadius.zero,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Get.theme.primaryColorDark,
                  width: 1,
                ),
                borderRadius: BorderRadius.zero,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Get.theme.primaryColorDark,
                  width: 1,
                ),
                borderRadius: BorderRadius.zero,
              ),
            ),
            style: TextStyle(fontSize: 13, color: Colors.black),
            cursorColor: Get.theme.primaryColorDark,
            cursorWidth: 1,
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: (() {
              controller.currentPageIndex.value = 1;
              onSearched();
            }),
            child: Container(
                alignment: Alignment.center,
                height: 27,
                width: 50,
                decoration: BoxDecoration(color: Get.theme.primaryColorDark),
                child: Text(
                  '搜索',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                )),
          ),
        ),
        // Padding(padding: EdgeInsets.only(left: 15), child: Obx(() => Text('${controller.gameCount.value}款'))),
        Spacer(),
        Padding(
            padding: EdgeInsets.only(right: 5),
            child: Obx(() {
              var pageNum = (controller.gameCount.value / 12).ceil();
              return RichText(
                  text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(text: '第'),
                  TextSpan(text: '${controller.currentPageIndex.value}', style: TextStyle(color: Colors.red)),
                  TextSpan(text: '/'),
                  TextSpan(text: '$pageNum'),
                  TextSpan(text: '页  '),
                  TextSpan(text: '${controller.gameCount.value}', style: TextStyle(color: Colors.blue)),
                  TextSpan(text: '款'),
                ],
              ));
            })),
        MyButton(
          title: '上一页',
          onPressed: () {
            controller.currentPageIndex.value--;
            if (controller.currentPageIndex.value <= 0) {
              controller.currentPageIndex.value = 1;
            }
            onPreviousPage();
          },
        ),
        MyButton(
          title: '下一页',
          onPressed: () {
            controller.currentPageIndex.value++;
            onNextPage();
          },
        ),
      ],
    );
  }
}
