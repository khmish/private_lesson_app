import 'dart:convert';

import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:http/http.dart' as http;

class LeveleducationAPI {
  static var _baseUrlLeveleducations =
      base_url+'leveleducation';

  // get level education*****************************************************
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
      //
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
      return leveleducationList;
    }
  }

  // delete level education*****************************************************
  static Future<bool> deleteLeveleducation(String id) async {
    var baseUrl = _baseUrlLeveleducations;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlLeveleducations + "/$id";
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        // dynamic body = json.decode(response.body)['data'];

        return true;
      } else {
        // storage.setString("token", "");
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // show a level education*****************************************************
  static Future<Leveleducation> getALeveleducation(String id) async {
    var baseUrl = _baseUrlLeveleducations;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlLeveleducations + "/$id";
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

      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];
        Leveleducation leveleducation = Leveleducation.fromJson(body);
        return leveleducation;
      } else {
        // storage.setString("token", "");
        return new Leveleducation(name: "", id: -1);
      }
    } catch (e) {
      return new Leveleducation(name: "", id: -1);
    }
  }

  // update a level education*****************************************************
  static Future<Leveleducation> updateALeveleducation(
      Leveleducation leveleducation) async {
    var baseUrl = _baseUrlLeveleducations;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlLeveleducations + "/${leveleducation.id}";
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.put(
        url,
        body: jsonEncode(leveleducation),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];
        Leveleducation leveleducation = Leveleducation.fromJson(body);
        return leveleducation;
      } else {
        // storage.setString("token", "");
        return new Leveleducation(name: "", id: -1);
      }
    } catch (e) {
      return new Leveleducation(name: "", id: -1);
    }
  }

//****************Add level education***********************************
  static Future<void> addLeveleducations(String leveleducationName) async {
    var baseUrl = _baseUrlLeveleducations;
    try {
      baseUrl = _baseUrlLeveleducations;
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: {
          "name": leveleducationName,
        },
      );

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {}
  }
}
