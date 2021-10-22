import 'dart:convert';

import 'package:private_lesson_app/models/subject.dart';
import 'package:http/http.dart' as http;

class SubjectAPI {
  static var _baseUrlSubjects = 'https://privatelesson.herokuapp.com/api/subject';
  static Future<List<Subject>> getSubjects() async {
    var baseUrl = _baseUrlSubjects;
    List<Subject> subjectList = [];
    try {
      // if (page > 0) {
      baseUrl = _baseUrlSubjects;
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
          Subject subject = Subject.fromJson(body[i]);
          subjectList.add(subject);
        }
        return subjectList;
      } else {
        return subjectList;
      }
    } catch (e) {
      print(e);
      return subjectList;
    }
  }
}
