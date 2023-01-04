import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:switch_game/widgets/msg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

class ToolsItem extends GetView {
  final String name;
  final String icon;
  final String summary;
  final String downUrl;
  const ToolsItem({
    super.key,
    required this.name,
    required this.icon,
    required this.summary,
    required this.downUrl,
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
                  text: '打开应用',
                  onPressed: () {
                    final winNotify = WindowsNotification(applicationId: 'Switch游戏');
                    NotificationMessage message = NotificationMessage.fromPluginTemplate('id', 'hello', 'world');
                    winNotify.showNotificationPluginTemplate(message);
                  },
                  color: Colors.red,
                ),
                SizedBox(width: 5),
                GFButton(
                  shape: GFButtonShape.square,
                  onPressed: () {
                    var arr = downUrl.split('&&&&');
                    if (arr.length == 2) {
                      Clipboard.setData(ClipboardData(text: arr[1]));
                      if (Get.isSnackbarOpen) {
                        return;
                      }
                      Msg.confirm(
                        '提示',
                        '密码已复制,在网页中直接粘贴即可',
                        onOK: () {
                          Get.back();
                          launchUrl(Uri.parse(arr[0]));
                        },
                        onCancel: null,
                        barrierDismissible: false,
                      );
                      //
                    }
                  },
                  size: 25,
                  text: '立即下载',
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
