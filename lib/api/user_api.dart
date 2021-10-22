import 'dart:convert';

import 'package:private_lesson_app/models/user.dart';
import 'package:http/http.dart' as http;

class UserAPI {
  static var _baseUrlUsers = 'https://privatelesson.herokuapp.com/api/user';
  static Future<List<User>> getUsers() async {
    var baseUrl = _baseUrlUsers;
    List<User> userList = [];
    try {
      // if (page > 0) {
      baseUrl = _baseUrlUsers;
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.get(
        url,
        // headers: <String, String>{
        //   'Accept': 'application/json',
        //   'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $token',
        // },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];

        for (var i = 0; i < body.length; i++) {
          User user = User.fromJson(body[i]);
          userList.add(user);
        }
        return userList;
      } else {
        return userList;
      }
    } catch (e) {
      print(e);
      return userList;
    }
  }
}
