import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:switch_game/app/pages/tools/controllers/tools_controller.dart';
import 'package:switch_game/widgets/msg.dart';
import 'package:url_launcher/url_launcher.dart';

class AppPath extends GetView<ToolsController> {
  const AppPath({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20, bottom: 20, right: 30, left: 30),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: controller.toolList
                .map((e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('设置${e['name']}路径', style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 25,
                              width: 400,
                              padding: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                //color: Colors.black12,
                                border: Border.all(color: Color.fromARGB(255, 195, 195, 195), width: 0.5),
                              ),
                              child: Text(
                                e['path'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              child: GFButton(
                                color: Color.fromARGB(255, 195, 195, 195),
                                shape: GFButtonShape.square,
                                onPressed: () async {
                                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                                    initialDirectory: Directory.current.path,
                                    dialogTitle: '选择${e['name']}路径',
                                    type: FileType.custom,
                                    allowedExtensions: ['exe'],
                                  );
                                  var filePath = result?.files.single.path;
                                  if (filePath != null) {
                                    e['path'] = filePath;
                                    final box = GetStorage();
                                    box.write('${e['key']}_path', filePath);
                                    controller.toolList.refresh();
                                  }
                                },
                                text: '...',
                                size: 25,
                              ),
                            ),
                            SizedBox(width: 10),
                            GFButton(
                              shape: GFButtonShape.square,
                              onPressed: () {
                                var arr = e['down_url'].toString().split('&&&&');
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
                        )
                      ],
                    ))
                .toList(),
          ),
        ));
  }
}
