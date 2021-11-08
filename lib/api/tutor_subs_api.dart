import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/models/tutor_subs.dart';

class TutorSubsAPI {
  static var _baseUrlTutorSubs = 'https://privatelesson.herokuapp.com/api/tutor-sub';
  
  static Future<List<TutorSubs>> getTutorsSubs() async {
    var baseUrl = _baseUrlTutorSubs;
    List<TutorSubs> tutorList = [];
    try {
      // if (page > 0) {
      baseUrl = _baseUrlTutorSubs;
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
          TutorSubs tutor = TutorSubs.fromJson(body[i]);
          tutorList.add(tutor);
        }
        return tutorList;
      } else {
        return tutorList;
      }
    } catch (e) {
      print(e);
      return tutorList;
    }
  }
  static Future<bool> addTutorSubs(TutorSubs tutorSubs) async {
    var baseUrl = _baseUrlTutorSubs;
    
    try {
      // if (page > 0) {
      baseUrl = _baseUrlTutorSubs;
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: jsonEncode(tutorSubs),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );
      // print(response.body);
      if (response.statusCode == 201) {
        
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
  static Future<bool> updateTutor(TutorSubs tutorSubs) async {
    var baseUrl = _baseUrlTutorSubs;
    
    try {
      // if (page > 0) {
      baseUrl = _baseUrlTutorSubs+'/${tutorSubs.id}';
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.put(
        url,
        body: jsonEncode(tutorSubs),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
  static Future<bool> deleteTutor(String tutorSubsId) async {
    var baseUrl = _baseUrlTutorSubs;
    
    try {
      // if (page > 0) {
      baseUrl = _baseUrlTutorSubs+'/$tutorSubsId';
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
      // print(response.body);
      if (response.statusCode == 204) {
        
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

}
