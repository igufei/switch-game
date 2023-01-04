import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/app/pages/game/controllers/game_controller.dart';
import 'package:switch_game/widgets/my_button.dart';

class SearchBar extends GetView<GameController> {
  final dynamic Function() onSearched;
  final dynamic Function() onNextPage;
  final dynamic Function() onPreviousPage;
  const SearchBar({
    super.key,
    required this.onSearched,
    required this.onNextPage,
    required this.onPreviousPage,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          height: 27,
          child: CupertinoTextField(
            prefix: Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Icon(
                Icons.search,
                size: 17,
                color: Get.theme.primaryColorDark,
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Get.theme.primaryColorDark, // Color(0xff2c2c41),
                  width: 1,
                )),
            cursorColor: Get.theme.primaryColorDark, // Color(0xff2c2c41),
            placeholder: '请输入游戏名称',
            placeholderStyle: TextStyle(fontSize: 13, color: Colors.black54),
            style: TextStyle(fontSize: 13, color: Colors.black),
            padding: EdgeInsets.only(left: 5, right: 5, top: 2.5, bottom: 2.5),
            controller: controller.gameNameC,
            cursorWidth: 1,
            cursorHeight: 18,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.left,
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

              return Text('第${controller.currentPageIndex.value}/$pageNum页  ${controller.gameCount.value}款');
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
