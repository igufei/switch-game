import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(minWidth: 600),
        child: Row(
          children: <Widget>[
            Obx(() => NavigationRail(
                  //backgroundColor: Color(0xff00b6dd), //背影色
                  //extended: true, //扩展显示，在图标的右边显示出文字
                  elevation: 5, //阴影
                  //groupAlignment: 0,图标组上下显示的位置，范围是-1.0至1.0
                  //labelType: NavigationRailLabelType.all,文本显示的类型，
                  minExtendedWidth: 140,
                  selectedIconTheme: IconThemeData(color: Get.theme.primaryColorDark, size: 30),
                  unselectedIconTheme: IconThemeData(color: Colors.black, size: 30),
                  destinations: const [
                    NavigationRailDestination(
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.games),
                      label: Text('游戏'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.feed),
                      label: Text('存档'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.key),
                      label: Text('金手指'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.lunch_dining),
                      label: Text('Mod'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.folder),
                      label: Text('工具'),
                    ),
                  ],
                  selectedIndex: controller.pageIndex.value,
                  onDestinationSelected: (value) {
                    controller.pageIndex.value = value;
                  },
                  trailing: Expanded(
                      child: Container(
                    padding: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "版本 v0.01",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  )),
                )),
            VerticalDivider(thickness: 1, width: 1),
            Obx(() => Expanded(
                  child: controller.pages[controller.pageIndex.value],
                ))
          ],
        ),
      ),
    );
  }
}
