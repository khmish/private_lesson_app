import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/models/tutor_leveleduction.dart';

class TutorLeveleducationAPI {
  static var _baseUrlTutorleveleducation =
      'https://privatelesson.herokuapp.com/api/tutor-level-education';

  static Future<List<TutorLeveleducation>> getTutorsleveleducation() async {
    var baseUrl = _baseUrlTutorleveleducation;
    List<TutorLeveleducation> tutorList = [];
    try {
      // if (page > 0) {
      baseUrl = _baseUrlTutorleveleducation;
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
          TutorLeveleducation tutor = TutorLeveleducation.fromJson(body[i]);
          tutorList.add(tutor);
        }
        return tutorList;
      } else {
        return tutorList;
      }
    } catch (e) {
      return tutorList;
    }
  }

  static Future<bool> addTutorleveleducation(
      TutorLeveleducation tutorleveleducation) async {
    var baseUrl = _baseUrlTutorleveleducation;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlTutorleveleducation;
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: jsonEncode(tutorleveleducation),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );
      //
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateTutor(
      TutorLeveleducation tutorleveleducation) async {
    var baseUrl = _baseUrlTutorleveleducation;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlTutorleveleducation + '/${tutorleveleducation.id}';
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.put(
        url,
        body: jsonEncode(tutorleveleducation),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );
      //
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteTutor(String tutorleveleducationId) async {
    var baseUrl = _baseUrlTutorleveleducation;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlTutorleveleducation + '/$tutorleveleducationId';
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.delete(
        url,
        // body: jsonEncode(tutor),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );
      //
      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
