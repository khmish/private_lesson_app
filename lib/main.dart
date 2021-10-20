import 'package:flutter/material.dart';
import 'package:private_lesson_app/pages/main_search.dart';
import 'package:private_lesson_app/pages/signup.dart';
import 'package:private_lesson_app/pages/city.dart';
import 'pages/login.dart';

void main() {
  runApp(
    MaterialApp(
      home: SearchWidget(),
      // home: SignupWidget(),
      // home: LoginPageWidget(),
      // home: CityWidget(),
    )
  );
}
