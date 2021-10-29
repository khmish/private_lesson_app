import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:private_lesson_app/models/user.dart';

class TutorSearch {
  static var _baseUrlUsers =
      'https://privatelesson.herokuapp.com/api/user/search';
      // 'http://192.168.100.49/privateLesson/public/api/user/search';
  
  static Future<List<User>> searchForTutorsWithParams([int? leveleducationId ,String? gender="",int? subjectId,int? cityId]) async {
    var baseUrl = _baseUrlUsers;
    List<User> userList = [];
    try {
      // if (page > 0) {
      baseUrl = _baseUrlUsers;

      // }
      var url = Uri.parse(baseUrl);
      // if()
      var response = await http.post(
        url,
        body: jsonEncode({
          "leveleducation_id": leveleducationId,
          "gender": gender,
          "subject_id": subjectId,
          "city_id": cityId,
        }),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token',
        },
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
