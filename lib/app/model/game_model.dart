import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;
import 'package:switch_game/app/data/category_data.dart';
import 'package:switch_game/app/data/game_data.dart';

class GameModel {
  static List<dynamic> _gameList = [];
  static String categoryId2Text(int categoryID) {
    List<dynamic> categorys = jsonDecode(categoryData);
    for (var item in categorys) {
      var id = item['ID'];
      var name = item['Name'];
      if (id == categoryID) {
        return name.toString();
      }
    }
    return '未知';
  }

  static int count(int categoryID, String gameName, int pageIndex) {
    List<GameSchame> list = [];
    gameName = gameName.trim();
    for (var item in _gameList) {
      var game = _parseData(item);
      if (categoryID == game.categoryID) {
        if (game.name == '') {
          list.add(game);
        } else if (game.name.contains(gameName)) {
          list.add(game);
        }
      } else if (categoryID == 0) {
        if (game.name == '') {
          list.add(game);
        } else if (game.name.contains(gameName)) {
          list.add(game);
        }
      }
    }
    return list.length;
  }

  static Future<GameSchame?> findByGameID(int id) async {
    for (int i = 0; i < _gameList.length; i++) {
      var item = _gameList[i];
      var game = _parseData(item);
      if (id == game.id) {
        if (game.slug != '') {
          var dio = Dio();
          var res = await dio.get(game.slug);
          var doc = parse(res.data.toString());
          var summary = doc.querySelector('#tabs-intro > div.bottommargin-sm')?.text;
          var score = doc.querySelector('#scores > svg > text.st2.st3.st5')?.text;
          var publishDate = doc.querySelector('p.gamedb-release')?.text;
          var detailsImages = doc.querySelectorAll('li.slide');
          List<String> imageList = [];
          for (var item in detailsImages) {
            var image = item.querySelector('a')?.attributes['href'];
            if (image != null) {
              imageList.add(image);
            }
          }
          var newGame = GameSchame(
              id: id,
              name: game.name,
              version: game.version,
              language: game.language,
              score: score ?? '',
              publishDate: publishDate ?? '',
              englishName: game.englishName,
              baiduDownUrl: game.baiduDownUrl,
              aliDownUrl: game.aliDownUrl,
              categoryID: game.categoryID,
              detailsImages: imageList.isEmpty ? game.detailsImages : imageList,
              cover: game.cover,
              summary: summary ?? '',
              slug: game.slug,
              other: game.other);
          return newGame;
        }
        return game;
      }
    }
    return null;
  }

  static List<GameSchame> findMany(int categoryID, String gameName, int pageIndex) {
    List<GameSchame> list = [];
    gameName = gameName.trim();
    for (var item in _gameList) {
      var game = _parseData(item);
      if (categoryID == game.categoryID) {
        if (game.name == '') {
          list.add(game);
        } else if (game.name.contains(gameName)) {
          list.add(game);
        }
      } else if (categoryID == 0) {
        if (game.name == '') {
          list.add(game);
        } else if (game.name.contains(gameName)) {
          list.add(game);
        }
      }
    }
    return _sublist(list, pageIndex);
  }

  static void initData() {
    _gameList = jsonDecode(gameData) as List;
    _gameList.shuffle();
  }

  static GameSchame _parseData(Map data) {
    var info = data['Name'].toString();
    var infoArr = info.split('|');
    if (infoArr.length == 1) {
      infoArr = info.split('/');
    }
    var name = infoArr[0];
    var language = '';
    var version = '';
    var slug = '';
    var englishName = '';
    if (infoArr.length >= 3) {
      version = infoArr[2];
    }
    if (infoArr.length >= 2) {
      language = infoArr[1];
    }
    var cover = 'http://d.51switch.cn/m_${data['CoverPath']}';
    var indienova = data['indienova'];
    if (indienova != null) {
      slug = 'https://indienova.com/game/${indienova['slug']}';
      var title = indienova['title'];
      var titleArr = title.toString().split('|');
      if (titleArr.length == 5) {
        englishName = titleArr[0];
        var newName = titleArr[2];
        if (newName != '') {
          name = newName;
        }
        var newCover = titleArr[4]; //gamedb-logo-thumb.png
        if (!newCover.contains('gamedb-logo-thumb')) {
          cover = newCover;
        }
      }
    }
    var game = GameSchame(
      id: data['ID'],
      name: name,
      version: version,
      language: language,
      score: "0",
      publishDate: '',
      englishName: englishName,
      baiduDownUrl: data['DownloadUrl'],
      aliDownUrl: data['AliUrl'],
      categoryID: data['CategoryId'],
      detailsImages: ['http://d.51switch.cn/m_${data['CoverPath']}'],
      cover: cover,
      summary: '',
      slug: slug,
      other: '',
    );
    return game;
  }

  static List<GameSchame> _sublist(List<GameSchame> list, int pageIndex) {
    var pageSize = 15;
    var startIndex = (pageIndex - 1) * pageSize;
    var endIndex = startIndex + pageSize;
    if (startIndex >= list.length) {
      return [];
    }
    if (endIndex > list.length) {
      endIndex = list.length;
    }
    return list.sublist(startIndex, endIndex);
  }
}

class GameSchame {
  final int id;
  final String name;
  final String version;
  final String language;
  final String score;
  final String publishDate;
  final String englishName;
  final String baiduDownUrl;
  final String aliDownUrl;
  final int categoryID;
  final List<String> detailsImages;
  final String cover;
  final String summary;
  final String slug;
  final String other;

  GameSchame({
    required this.id,
    required this.name,
    required this.version,
    required this.language,
    required this.score,
    required this.publishDate,
    required this.englishName,
    required this.baiduDownUrl,
    required this.aliDownUrl,
    required this.categoryID,
    required this.detailsImages,
    required this.cover,
    required this.summary,
    required this.slug,
    required this.other,
  });
}
