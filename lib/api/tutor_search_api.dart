import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/tutor_subs_lvl_ed.dart';

class TutorSearch {
  static var _baseUrlUsers =
      base_url+'user/search';
  // 'http://192.168.100.49/privateLesson/public/api/user/search';

  static Future<List<TutorSubsLvEd>> searchForTutorsWithParams(
      {int? leveleducationId,
      String? gender = "",
      int? subjectId,
      int? cityId}) async {
    var baseUrl = _baseUrlUsers;
    List<TutorSubsLvEd> tutorsList = [];
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
      //
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];

        for (var i = 0; i < body.length; i++) {
          TutorSubsLvEd tutorSubLvl = TutorSubsLvEd.fromJson(body[i]);
          tutorsList.add(tutorSubLvl);
        }
        return tutorsList;
      } else {
        return tutorsList;
      }
    } catch (e) {
      return tutorsList;
    }
  }
}
