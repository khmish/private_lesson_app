import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/models/tutor.dart';
import 'package:private_lesson_app/models/tutor_subs_lvl_ed.dart';
import 'package:private_lesson_app/models/user.dart';

class TutorAPI {
  static var _baseUrlTutor = 'https://privatelesson.herokuapp.com/api/tutor';

  //---------------------------------- show tutor ----------------------------------//
  static Future<TutorSubsLvEd> getATutor(String id) async {
    var baseUrl = _baseUrlTutor;
    try {
      baseUrl = _baseUrlTutor + "/getTutorByUser/${id}";
      var url = Uri.parse(baseUrl);
      var response = await http.get(
        url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'][0];
        TutorSubsLvEd tutor = TutorSubsLvEd.fromJson(body);
        return tutor;
      } else {}
    } catch (e) {}
    return new TutorSubsLvEd(
        id: -1, rating: 0, subjects: [], levelEductions: []);
  }

  static Future<List<Tutor>> getTutors() async {
    var baseUrl = _baseUrlTutor;
    List<Tutor> tutorList = [];
    try {
      // if (page > 0) {
      baseUrl = _baseUrlTutor;
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
          Tutor tutor = Tutor.fromJson(body[i]);
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

  static Future<Tutor> addTutor(Tutor tutor) async {
    // Tutor tutor = new Tutor(id:-1,userId: 0, titleCert: "", price: "", type: "");
    var baseUrl = _baseUrlTutor;
    try {
      // if (page > 0) {
      baseUrl = _baseUrlTutor;
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: jsonEncode(tutor),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );
      //
      if (response.statusCode == 201) {
        dynamic body = json.decode(response.body)['data'];
        tutor = Tutor.fromJson(body);
        return tutor;
      } else {
        return tutor;
      }
    } catch (e) {
      return tutor;
    }
  }

  static Future<Tutor> updateTutor(Tutor tutor) async {
    var baseUrl = _baseUrlTutor;
    Tutor tutor =
        new Tutor(id: -1, userId: 0, titleCert: "", price: "", type: "");

    try {
      // if (page > 0) {
      baseUrl = _baseUrlTutor + '/${tutor.id}';
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.put(
        url,
        body: jsonEncode(tutor),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );
      //
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];
        tutor = Tutor.fromJson(body);
        return tutor;
      } else {
        return tutor;
      }
    } catch (e) {
      return tutor;
    }
  }

  static Future<bool> deleteTutor(String tutorId) async {
    var baseUrl = _baseUrlTutor;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlTutor + '/$tutorId';
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
