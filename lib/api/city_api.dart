import 'dart:convert';

import 'package:private_lesson_app/models/city.dart';
import 'package:http/http.dart' as http;

class CityAPI {
  static var _baseUrlCities = 'https://privatelesson.herokuapp.com/api/city';
  static var _baseUrlDeleteCity =
      'https://privatelesson.herokuapp.com/api/city';

  // get city*****************************************************
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

  // delete city*****************************************************
  static Future<bool> deleteCity(String id) async {
    var baseUrl = _baseUrlDeleteCity;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlDeleteCity + "/$id";
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
      print(response.body);
      if (response.statusCode == 204) {
        // dynamic body = json.decode(response.body)['data'];

        return true;
      } else {
        // storage.setString("token", "");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  // show a city*****************************************************
  static Future<City> getACity(String id) async {
    var baseUrl = _baseUrlDeleteCity;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlDeleteCity + "/$id";
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
      print(response.body);
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];
        City city = City.fromJson(body);
        return city;
      } else {
        // storage.setString("token", "");
        return new City(countryName: "", name: "", id: -1);
      }
    } catch (e) {
      print(e);
      return new City(countryName: "", name: "", id: -1);
    }
  }

  // update a city*****************************************************
  static Future<City> updateACity(City city) async {
    var baseUrl = _baseUrlDeleteCity;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlDeleteCity + "/${city.id}";
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.put(
        url,
        // body: jsonEncode({
        //   "id":city.id,
        //   "name":city.name,
        //   "country_name":city.countryName,
        // }),
        body: jsonEncode(city),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];
        City city = City.fromJson(body);
        return city;
      } else {
        // storage.setString("token", "");
        return new City(countryName: "", name: "", id: -1);
      }
    } catch (e) {
      print(e);
      return new City(countryName: "", name: "", id: -1);
    }
  }

//****************Add city
  static var _baseURL = 'https://privatelesson.herokuapp.com/api/city';
  static Future<void> addCities(String cityName, String countryName) async {
    var baseUrl = _baseURL;
    try {
      baseUrl = _baseURL;
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: {
          "name": cityName,
          "country_name": countryName,
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
