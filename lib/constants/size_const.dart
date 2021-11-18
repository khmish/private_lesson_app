import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

double constLeft = 15, constTop = 20, constRight = 15, constBottom = 0;
double constLeftBtn = 20,
    constTopBtn = 40,
    constRightBtn = 20,
    constBottomBtn = 50;
Future<User> checksIfLogIn() async {
  // bool isLogged = false;
  final storage = await SharedPreferences.getInstance();
  String token = storage.getString("token").toString();
  print(token + " ********************* ");
  User user = await UserAPI.me(token);
  return user;
}

Color colorAppBar = Color(0xFF2F2F2F);
Color colorBG = Color(0xFF9E9E9E);
Color colorText = Color(0xFFFF6F25);
Color colorBox = Colors.white;
