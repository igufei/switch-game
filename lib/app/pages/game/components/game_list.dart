import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/app/model/game_model.dart';
import 'package:switch_game/app/pages/game/components/search_bar.dart';
import 'package:switch_game/app/pages/game/controllers/game_controller.dart';

import 'category.dart';
import 'game_details.dart';
import 'game_item.dart';

class GameList extends GetView<GameController> {
  const GameList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Category(
                categoryIndex: controller.currentCategoryIndex.value,
                categorys: controller.category,
                onChanged: (index, categoryID) {
                  controller.currentCategoryIndex.value = index;
                  controller.currentCategoryID.value = categoryID;
                  controller.gameNameC.text = '';
                  controller.currentPageIndex.value = 1;
                  controller.loadGames();
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
            child: SearchBar(
              onSearched: () {
                controller.currentCategoryIndex.value = 0;
                controller.currentCategoryID.value = 0;
                controller.currentPageIndex.value = 1;
                controller.loadGames();
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: controller.sc,
              child: Obx(() {
                return controller.games.length > 0
                    ? Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 5, top: 5),
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Wrap(
                          spacing: 10.0,
                          runSpacing: 7.0,
                          children: controller.games
                              .map((element) => GameItem(
                                    game: element,
                                    onClick: (id) async {
                                      var game = await GameModel.findByGameID(id);
                                      controller.rc.next(GameDetails(game: game!));
                                    },
                                  ))
                              .toList(),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 100),
                        alignment: Alignment.center,
                        child: Text(
                          locale: Locale('zh', 'CN'),
                          '没有任何数据',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
