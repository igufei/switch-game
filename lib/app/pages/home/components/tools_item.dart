import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:switch_game/app/pages/tools/components/app_path.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ToolsItem extends GetView {
  final String name;
  final String icon;
  final String summary;
  final String path;
  const ToolsItem({
    super.key,
    required this.name,
    required this.icon,
    required this.summary,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        width: 500,
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  icon,
                  width: 35,
                ),
                SizedBox(width: 10),
                Text(
                  name,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                GFButton(
                  shape: GFButtonShape.square,
                  size: 25,
                  text: '立即启动',
                  onPressed: () async {
                    var exists = await File(path).exists();
                    if (!exists) {
                      Get.dialog(
                        Dialog(child: AppPath()),
                        barrierDismissible: true,
                      );
                    } else {
                      launchUrlString(path);
                    }

                    /* final winNotify = WindowsNotification(applicationId: 'Switch游戏');
                    NotificationMessage message = NotificationMessage.fromPluginTemplate('id', 'hello', 'world');
                    winNotify.showNotificationPluginTemplate(message); */

                    /* WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                content: Webview(
                                  controller,
                                ),
                              ));
                    }); */
                  },
                  color: Colors.red,
                ),
              ],
            ),
            Text(
              summary,
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
