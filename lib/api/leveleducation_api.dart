import 'dart:convert';

import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:http/http.dart' as http;

class LeveleducationAPI {
  static var _baseUrlLeveleducations = 'https://privatelesson.herokuapp.com/api/leveleducation';
  static Future<List<Leveleducation>> getLeveleducations() async {
    var baseUrl = _baseUrlLeveleducations;
    List<Leveleducation> leveleducationList = [];
    try {
      // if (page > 0) {
      baseUrl = _baseUrlLeveleducations;
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.get(
        url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];

        for (var i = 0; i < body.length; i++) {
          Leveleducation leveleducation = Leveleducation.fromJson(body[i]);
          leveleducationList.add(leveleducation);
        }
        return leveleducationList;
      } else {
        return leveleducationList;
      }
    } catch (e) {
      print(e);
      return leveleducationList;
    }
  }
}
