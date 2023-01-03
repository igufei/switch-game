import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:switch_game/app/model/game_model.dart';
import 'package:switch_game/widgets/msg.dart';
import 'package:url_launcher/url_launcher.dart';

class GameDetails extends GetView {
  final GameSchame game;
  const GameDetails({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    var typeText = GameModel.categoryId2Text(game.categoryID);
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        //border: Border.all(color: Color.fromARGB(255, 234, 233, 233), width: 0.1),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              game.cover.contains('indienova')
                  ? Image.network(
                      game.cover,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      headers: const {'referer': 'https://indienova.com/'},
                    )
                  : Image.network(
                      game.cover,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
              Container(
                padding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          game.name,
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            game.englishName,
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 15),
                          width: 200,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Text(
                                  '游戏类别',
                                  style: TextStyle(color: Color(0xff9497a0)),
                                ),
                              ),
                              Text(
                                typeText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 15),
                          width: 200,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Text(
                                  '游戏语言',
                                  style: TextStyle(color: Color(0xff9497a0)),
                                ),
                              ),
                              Text(
                                game.language == '' ? '-' : game.language,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Text(
                                '游戏版本',
                                style: TextStyle(color: Color(0xff9497a0)),
                              ),
                            ),
                            Text(
                              game.version == '' ? '-' : game.version,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 15),
                          width: 200,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Text(
                                  '发布日期',
                                  style: TextStyle(color: Color(0xff9497a0)),
                                ),
                              ),
                              Text(
                                game.publishDate == '' ? '-' : game.publishDate,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 15),
                          width: 200,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Text(
                                  '媒体评分',
                                  style: TextStyle(color: Color(0xff9497a0)),
                                ),
                              ),
                              Text(
                                game.score == '' ? '-.-' : game.score,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GFButton(
                          onPressed: () {
                            //print(game.baiduDownUrl);
                            launchUrl(Uri.parse(game.baiduDownUrl.replaceFirst('&&&&', '?pwd=')));
                          },
                          shape: GFButtonShape.square,
                          size: GFSize.SMALL,
                          //text: '百度网盘下载',
                          color: Colors.white,
                          //borderSide: BorderSide(color: Colors.black12, width: 0.5),
                          child: Image.network(
                            'https://pan.baidu.com/box-static/disk-theme/theme/white/img/logo@2x.png',
                            height: 20,
                          ),
                        ),
                        if (game.aliDownUrl != '')
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: GFButton(
                              onPressed: () {
                                var arr = game.aliDownUrl.split('&&&&');
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
                              //text: '阿里网盘下载',
                              shape: GFButtonShape.square,
                              size: GFSize.SMALL,
                              color: Colors.white,
                              //borderSide: BorderSide(color: Colors.black12),
                              child: Image.network(
                                'https://img.alicdn.com/imgextra/i3/O1CN01qcJZEf1VXF0KBzyNb_!!6000000002662-2-tps-384-92.png',
                                height: 20,
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(game.summary.trim()),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 400,
              autoPlay: true,
              enlargeCenterPage: true,
              //: 2.0,
            ),
            items: game.detailsImages.map(
              (url) {
                return game.cover.contains('indienova')
                    ? Image.network(
                        url,
                        fit: BoxFit.fill,
                        headers: const {'referer': 'https://indienova.com/'},
                      )
                    : Image.network(
                        url,
                        fit: BoxFit.fill,
                      );
              },
            ).toList(),
          )
        ],
      ),
    );
  }
}
