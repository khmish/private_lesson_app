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
String base_url = "https://privatelesson.herokuapp.com/api/";
// String base_url = "http://127.0.0.1:8000/api/";
Future<User> checksIfLogIn() async {
  // bool isLogged = false;
  final storage = await SharedPreferences.getInstance();
  String token = storage.getString("token").toString();
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
//******************************* summer inverted mode********************* */
Color colorContainerBox = Color(0xFFe8dab2);
Color colorBackGround = Color(0xFFdd6e42);
Color colorMainText = Color(0xFF253237);
Color colorHeaderText = Colors.black;
Color colorInputTextBox = Colors.black45;
Color colorPrimaryBTN = Color(0xFF4f5d75);
Color colorSecondaryBTN = Color(0xFF68768F);
Color colorPrimaryText = Color(0xFFe8dab2);
Color colorSeText = Color(0xFFbfc0c0);

//******************************* summer mode********************* */
// Color colorContainerBox = Color(0xFFdd6e42);
// Color colorBackGround = Color(0xFFe8dab2);
// Color colorMainText = Color(0xFF253237);
// Color colorHeaderText = Colors.black;
// Color colorInputTextBox = Color(0xFF253237);
// Color colorPrimaryBTN = Color(0xFF4f5d75);
// Color colorSecondaryBTN = Color(0xFF8290AA);
// Color colorPrimaryText = Color(0xFFe8dab2);
// Color colorSeText = Color(0xFFbfc0c0);

//******************************* blue mode********************* */
// Color colorContainerBox = Color(0xFF73bbf7);
// Color colorBackGround = Color(0xFFebf5fe);
// Color colorMainText = Color(0xFF253237);
// Color colorHeaderText = Colors.black;
// Color colorInputTextBox = Colors.black45;
// Color colorPrimaryBTN = Color(0xFF2196f3);
// Color colorSecondaryBTN = Colors.blueGrey;
// Color colorPrimaryText = Color(0xFFe8dab2);
// Color colorSeText = Color(0xFFbfc0c0);


// ****************************** dark mode*******************
// Color colorContainerBox = Color(0xFF2d3142);
// Color colorBackGround = Color(0xFFbfc0c0);
// Color colorMainText = Color(0xFF000000);
// Color colorHeaderText = Colors.white60;
// Color colorInputTextBox = Colors.white60;
// Color colorPrimaryBTN = Color(0xFF949fb1);
// Color colorSecondaryBTN = Color(0xFF68768F);
// Color colorPrimaryText = Color(0xFF2d3142);
// Color colorSeText = Color(0xFFbfc0c0);
