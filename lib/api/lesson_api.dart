import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:private_lesson_app/models/lesson.dart';

class LessonAPI {
  static var _baseUrlLesson = 'http://privatelesson.herokuapp.com/api/lessson';

  // get Lesson*****************************************************
  static Future<List<Lesson>> getLessons(
      {String? studentId, String? teacherId}) async {
    var baseUrl = _baseUrlLesson;
    List<Lesson> lessonList = [];
    try {
      // if (page > 0) {
      studentId = studentId ?? '';
      teacherId = teacherId ?? '';
      baseUrl = _baseUrlLesson +
          "?student_id=" +
          studentId +
          "&teacher_id=" +
          teacherId;
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
          Lesson lesson = Lesson.fromJson(body[i]);
          lessonList.add(lesson);
        }
        return lessonList;
      } else {
        return lessonList;
      }
    } catch (e) {
      return lessonList;
    }
  }

  // delete Lesson*****************************************************
  static Future<bool> deleteLesson(String id) async {
    var baseUrl = _baseUrlLesson;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlLesson + "/$id";
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

  // show a Lesson*****************************************************
  static Future<Lesson> getALesson(String id) async {
    var baseUrl = _baseUrlLesson;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlLesson + "/$id";
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
        Lesson city = Lesson.fromJson(body);
        return city;
      } else {
        // storage.setString("token", "");
        dynamic bodyerror;
        return Lesson.fromJson(bodyerror);
      }
    } catch (e) {
      dynamic bodyerror;

      return Lesson.fromJson(bodyerror);
    }
  }

  // update a lesson*****************************************************
  static Future<Lesson> updateALesson(Lesson lesson) async {
    var baseUrl = _baseUrlLesson;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlLesson + "/${lesson.id}";
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.put(
        url,
        body: jsonEncode(lesson),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];
        Lesson lesson = Lesson.fromJson(body);
        return lesson;
      } else {
        dynamic bodyerror;
        // storage.setString("token", "");
        return Lesson.fromJson(bodyerror);
      }
    } catch (e) {
      dynamic bodyerror;
      return Lesson.fromJson(bodyerror);
    }
  }

//****************Add Lesson

  static Future<Lesson> addLesson(Lesson lesson) async {
    var baseUrl = _baseUrlLesson;
    try {
      baseUrl = _baseUrlLesson;
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: jsonEncode(lesson),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201) {
        dynamic body = json.decode(response.body)['data'];
        lesson = Lesson.fromJson(body);
        return lesson;
      } else {
        return lesson;
      }
    } catch (e) {
      return lesson;
    }
  }
}
