import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:switch_game/app/model/game_model.dart';
import 'package:switch_game/widgets/click.dart';

class GameItem extends GetView {
  final Function(int) onClick;
  final GameSchame game;

  const GameItem({
    super.key,
    required this.game,
    required this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    var typeText = GameModel.categoryId2Text(game.categoryID);
    return Click(
      onClick: () {
        onClick(game.id);
      },
      child: SizedBox(
        width: 300,
        //margin: EdgeInsets.only(top: 4, bottom: 4),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          elevation: 2,
          child: Row(
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
                width: 170,
                padding: EdgeInsets.only(top: 11, bottom: 5, right: 5, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale: Locale('zh', 'CN'),
                      game.name,
                      style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      locale: Locale('zh', 'CN'),
                      game.englishName,
                      style: TextStyle(fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            locale: Locale('zh', 'CN'),
                            '类型',
                            style: TextStyle(color: Color(0xff9497a0)),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            locale: Locale('zh', 'CN'),
                            typeText,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            locale: Locale('zh', 'CN'),
                            '语言',
                            style: TextStyle(color: Color(0xff9497a0)),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            locale: Locale('zh', 'CN'),
                            game.language == '' ? '-' : game.language,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            locale: Locale('zh', 'CN'),
                            '版本',
                            style: TextStyle(color: Color(0xff9497a0)),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            locale: Locale('zh', 'CN'),
                            game.version == '' ? '-' : game.version,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
