import 'dart:convert';

import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/register.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserAPI {
  static var _baseUrlUsers = base_url+'user';

  static Future<List<User>> getUsers() async {
    var baseUrl = _baseUrlUsers;
    List<User> userList = [];
    try {
      // if (page > 0) {
      baseUrl = _baseUrlUsers;
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
          User user = User.fromJson(body[i]);
          userList.add(user);
        }
        return userList;
      } else {
        return userList;
      }
    } catch (e) {
      return userList;
    }
  }

  static Future<User> login(String email, String password) async {
    final storage = await SharedPreferences.getInstance();
    var baseUrl = _baseUrlUsers + "/login";
    try {
      // if (page > 0) {
      baseUrl = _baseUrlUsers + "/login";
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        storage.setString("token", json.decode(response.body)['data']);

        return User.fromJson(json.decode(response.body)['user']);
      } else {
        storage.remove("token");

        return new User(
            id: -1, name: "", email: "", city: -1, phone: "", gender: "");
      }
    } catch (e) {
      return new User(
          id: -1, name: "", email: "", city: -1, phone: "", gender: "");
    }
  }

  static Future<User> me(String token) async {
    var baseUrl = _baseUrlUsers + "/me";
    try {
      // if (page > 0) {
      baseUrl = _baseUrlUsers + "/me";
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        dynamic user = json.decode(response.body);

        return User.fromJson(user);
      } else {
        return User(
            city: -1,
            id: -1,
            email: "",
            gender: "",
            name: "",
            phone: "",
            role: "");
      }
    } catch (e) {
      return User(
          city: -1,
          id: -1,
          email: "",
          gender: "",
          name: "",
          phone: "",
          role: "");
    }
  }

  // var _baseUrlRegisterUser = 'http://127.0.0.1:8000/api/user';
  static Future<User> registed(Register register) async {
    User user =
        new User(id: -1, name: "", email: "", city: 0, phone: "", gender: "");
    var baseUrl = _baseUrlUsers;
    final storage = await SharedPreferences.getInstance();
    try {
      // if (page > 0) {
      baseUrl = _baseUrlUsers;
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: jsonEncode(register),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );

      print(response.statusCode);
      if (response.statusCode == 201) {
        dynamic body = json.decode(response.body)['user'];
        dynamic token = json.decode(response.body)['data'];
        storage.setString("token", token);
        user = User.fromJson(body);
        return user;
      } else {
        return user;
      }
    } catch (e) {
      return user;
    }
  }

  static Future<bool> getLoginUser(String token) async {
    var baseUrl = _baseUrlUsers + "/me";

    try {
      // if (page > 0) {
      baseUrl = _baseUrlUsers + "/me";
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      //
      if (response.statusCode == 200) {
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

  static Future<bool> deleteUser(String id) async {
    var baseUrl = _baseUrlUsers;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlUsers + "/$id";
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

  // update a subject*****************************************************
  static Future<User> updateUser(User user) async {
    var baseUrl = _baseUrlUsers;

    try {
      // if (page > 0) {
      baseUrl = _baseUrlUsers + "/${user.id}";
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.put(
        url,
        body: jsonEncode(user),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];
        User user = User.fromJson(body);
        return user;
      } else {
        // storage.setString("token", "");
        return new User(
            name: "", email: "", city: -1, phone: "", gender: "", id: -1);
      }
    } catch (e) {
      return new User(
          name: "", email: "", city: -1, phone: "", gender: "", id: -1);
    }
  }
}
