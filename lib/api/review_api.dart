import 'dart:convert';

import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/models/review.dart';

class ReviewAPI {
  //---------------------------------- URL to api ----------------------------------//

  static var _baseUrlRating = base_url + 'review';

  //---------------------------------- add rate ----------------------------------//
  static Future<bool> addRate(Review review) async {
    var baseUrl = _baseUrlRating;
    try {
      baseUrl = _baseUrlRating;
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: jsonEncode(review),
      );

      if (response.statusCode == 201) {
        return true;
      } else {}
    } catch (e) {}
        return false;

  }

//---------------------------------- show rate ----------------------------------//
  static Future<Review> getARate(Review review) async {
    var baseUrl = _baseUrlRating;
    try {
      baseUrl = _baseUrlRating+"/getRating" ;
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "teacher_id":review.teacherId,
          "student_id":review.studentId
        }),
      );
      
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];
        Review review = Review.fromJson(body);
        return review;
      } 
    } catch (e) {
      
      
    }
    return new Review(id: -1,stars: -1,studentId: -1,teacherId: -1);
  }
}
