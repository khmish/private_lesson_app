import 'dart:convert';

import 'package:private_lesson_app/models/city.dart';
import 'package:http/http.dart' as http;

class CityAPI {

  //---------------------------------- URL to api ----------------------------------//

  static var _baseUrlCities = 'https://privatelesson.herokuapp.com/api/city';
  

  //---------------------------------- get city ----------------------------------//
  static Future<List<City>> getCities() async {
    var baseUrl = _baseUrlCities;
    List<City> cityList = [];
    try {
      baseUrl = _baseUrlCities;
      var url = Uri.parse(baseUrl);
      var response = await http.get(
        url,
      );
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
      return cityList;
    }
  }

  //---------------------------------- del city ----------------------------------//
  static Future<bool> deleteCity(String id) async {
    var baseUrl = _baseUrlCities;
    try {
      baseUrl = _baseUrlCities + "/$id";
      var url = Uri.parse(baseUrl);
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      
      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      
      return false;
    }
  }

  //---------------------------------- show city ----------------------------------//
  static Future<City> getACity(String id) async {
    var baseUrl = _baseUrlCities;
    try {
      baseUrl = _baseUrlCities + "/$id";
      var url = Uri.parse(baseUrl);
      var response = await http.get(
        url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];
        City city = City.fromJson(body);
        return city;
      } else {
        return new City(countryName: "", name: "", id: -1);
      }
    } catch (e) {
      
      return new City(countryName: "", name: "", id: -1);
    }
  }

  //---------------------------------- update city ----------------------------------//
  static Future<City> updateACity(City city) async {
    var baseUrl = _baseUrlCities;

    try {
      baseUrl = _baseUrlCities + "/${city.id}";
      var url = Uri.parse(baseUrl);
      var response = await http.put(
        url,
        body: jsonEncode(city),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];
        City city = City.fromJson(body);
        return city;
      } else {
        return new City(countryName: "", name: "", id: -1);
      }
    } catch (e) {
      
      return new City(countryName: "", name: "", id: -1);
    }
  }

  //---------------------------------- add city ----------------------------------//
  static Future<void> addCities(String cityName, String countryName) async {
    var baseUrl = _baseUrlCities;
    try {
      baseUrl = _baseUrlCities;
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: {
          "name": cityName,
          "country_name": countryName,
        },
      );
      
      if (response.statusCode == 200) {
      } else {
        
      }
    } catch (e) {
      
    }
  }
}
