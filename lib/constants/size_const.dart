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

Future<bool> checksIfHasToken() async {
  // bool isLogged = false;
  final storage = await SharedPreferences.getInstance();
  String token = storage.getString("token").toString();
  if (!token.contains("null") && token.isNotEmpty) {
    return true;
  }
  return false;
}

//******************************* summer mode********************* */
Color colorContainerBox = Color(0xFF303F9F);
Color colorBackGround = Color(0xFFBDBDBD);
Color colorMainText = Color(0xFF3F51B5);
Color colorHeaderText = Colors.black;
Color colorInputTextBox = Color(0xFFBDBDBD);
Color colorPrimaryBTN = Color(0xFF4f5d75);
Color colorSecondaryBTN = Color(0xFF8290AA);
Color colorPrimaryText = Color(0xFFe8dab2);
//******************************* summer inverted mode********************* */
// Color colorContainerBox = Color(0xFFe8dab2);
// Color colorBackGround = Color(0xFFdd6e42);
// Color colorMainText = Color(0xFF253237);
// Color colorHeaderText = Colors.black;
// Color colorInputTextBox = Colors.black45;
// Color colorPrimaryBTN = Color(0xFF4f5d75);
// Color colorSecondaryBTN = Color(0xFF68768F);
// Color colorPrimaryText = Color(0xFFe8dab2);

// ****************************** dark mode*******************
// Color colorContainerBox = Color(0xFF2d3142);
// Color colorBackGround = Color(0xFFbfc0c0);
// Color colorMainText = Color(0xFFef8354);
// Color colorHeaderText = Colors.white60;
// Color colorInputTextBox = Colors.white60;
// Color colorPrimaryBTN = Color(0xFFbfc0c0);
// Color colorSecondaryBTN = Color(0xFF68768F);
// Color colorPrimaryText = Color(0xFF2d3142);
