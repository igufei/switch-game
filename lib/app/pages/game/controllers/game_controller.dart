import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/app/data/category_data.dart';
import 'package:switch_game/app/model/game_model.dart';

class GameController extends GetxController {
  var viewIndex = 0.obs;
  var currentCategoryID = 0.obs;
  var currentCategoryIndex = 0.obs;
  var currentPageIndex = 1.obs;
  var games = <GameSchame>[].obs;
  Rx<Widget> gameDetail = SizedBox(width: 0).obs;
  TextEditingController gameNameC = TextEditingController();
  var category = <dynamic>[];
  void loadGames() {
    games.value = GameModel.findMany(currentCategoryID.value, gameNameC.text, currentPageIndex.value);
    games.refresh();
  }

  @override
  void onInit() {
    category = jsonDecode(categoryData);
    games.value = GameModel.findMany(currentCategoryID.value, gameNameC.text, currentPageIndex.value);
    super.onInit();
  }
}
//