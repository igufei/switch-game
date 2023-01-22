import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/app/data/category_data.dart';
import 'package:switch_game/app/models/game_model.dart';
import 'package:switch_game/widgets/desktop_route.dart';

class GameController extends GetxController {
  var gameCount = 0.obs;
  var currentCategoryID = 0.obs;
  var currentCategoryIndex = 0.obs;
  var currentPageIndex = 1.obs;
  var games = <GameSchame>[].obs;
  TextEditingController gameNameC = TextEditingController();
  ScrollController sc = ScrollController();
  RouteController rc = RouteController();

  var category = <dynamic>[];
  void loadGames() {
    games.value = GameModel.findMany(currentCategoryID.value, gameNameC.text, currentPageIndex.value);
    gameCount.value = GameModel.count(currentCategoryID.value, gameNameC.text, currentPageIndex.value);
    games.refresh();
    sc.jumpTo(0);
  }

  @override
  void onInit() {
    category = jsonDecode(categoryData);
    games.value = GameModel.findMany(currentCategoryID.value, gameNameC.text, currentPageIndex.value);
    gameCount.value = GameModel.count(currentCategoryID.value, gameNameC.text, currentPageIndex.value);
    //loadGames();
    sc.addListener(() {
      if (sc.position.pixels == sc.position.maxScrollExtent) {
        currentPageIndex.value = currentPageIndex.value + 1;
        var nextGames = GameModel.findMany(currentCategoryID.value, gameNameC.text, currentPageIndex.value);
        games.addAll(nextGames);
        games.refresh();
      }
    });
    super.onInit();
  }
}
//