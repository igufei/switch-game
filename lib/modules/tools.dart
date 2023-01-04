import 'dart:convert';

import 'package:dio/dio.dart';

class Tools {
  static Future<String> check() async {
    var dio = Dio();
    var res = await dio.get('http://www.igufei.com/oem/data');
    var data = jsonDecode(res.data);
    var sg = data['switch_game'];
    var status = sg['status'] as bool;
    var message = sg['message'] as String;
    if (status) {
      return '';
    }
    return message;
  }
}
