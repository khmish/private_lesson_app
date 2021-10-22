import 'dart:convert';

import 'package:private_lesson_app/models/city.dart';
import 'package:http/http.dart' as http;

class CityAPI {
  static var _baseUrlCities = 'https://privatelesson.herokuapp.com/api/city';
  static Future<List<City>> getCities() async {
    var baseUrl = _baseUrlCities;
    List<City> cityList = [];
    try {
      // if (page > 0) {
      baseUrl = _baseUrlCities;
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
          City city = City.fromJson(body[i]);
          cityList.add(city);
        }
        return cityList;
      } else {
        return cityList;
      }
    } catch (e) {
      print(e);
      return cityList;
    }
  }
}
