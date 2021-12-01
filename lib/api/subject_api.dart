import 'dart:convert';

import 'package:private_lesson_app/models/subject.dart';
import 'package:http/http.dart' as http;

class SubjectAPI {
  static var _baseUrlSubjects =
      'https://privatelesson.herokuapp.com/api/subject';

  // get subject *****************************************************
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
      //
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
      return subjectList;
    }
  }

  // delete subject*****************************************************
  static Future<bool> deleteSubject(String id) async {
    var baseUrl = _baseUrlSubjects;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlSubjects + "/$id";
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

  // show a subject*****************************************************
  static Future<Subject> getASubject(String id) async {
    var baseUrl = _baseUrlSubjects;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlSubjects + "/$id";
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
        Subject subject = Subject.fromJson(body);
        return subject;
      } else {
        // storage.setString("token", "");
        return new Subject(name: "", pic: "", leveleducation: -1, id: -1);
      }
    } catch (e) {
      return new Subject(name: "", pic: "", leveleducation: -1, id: -1);
    }
  }

  // update a subject*****************************************************
  static Future<Subject> updateASubject(Subject subject) async {
    var baseUrl = _baseUrlSubjects;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlSubjects + "/${subject.id}";
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.put(
        url,
        body: jsonEncode(subject),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];
        Subject subject = Subject.fromJson(body);
        return subject;
      } else {
        // storage.setString("token", "");
        return new Subject(name: "", pic: "", leveleducation: -1, id: -1);
      }
    } catch (e) {
      return new Subject(name: "", pic: "", leveleducation: -1, id: -1);
    }
  }

//****************Add subject***********************************
  static Future<bool> addSubjects(Subject subject) async {
    var baseUrl = _baseUrlSubjects;
    try {
      // if (page > 0) {
      baseUrl = _baseUrlSubjects;
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: jsonEncode(subject),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );

      print(response.statusCode);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
