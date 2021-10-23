import 'package:flutter/material.dart';
import 'package:private_lesson_app/pages/main_search.dart';
import 'package:private_lesson_app/pages/search.dart';
import 'package:private_lesson_app/pages/signup.dart';
import 'package:private_lesson_app/pages/city.dart';

import 'pages/login.dart';
import 'pages/user.dart';

void main() {
  runApp(MaterialApp(


    // initialRoute: '/',
    //initialRoute: '/user',

    initialRoute: '/singup',

    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => SearchWidget(),
      '/singup': (context) => SignupWidget(),
      '/login': (context) => LoginPageWidget(),
      '/city': (context) => CityWidget(),
      '/searchPage': (context) => SearchPageWidget(),
      '/user': (context) => userPageWidget(),

      // '/permissions': (context) => permissions(),


    },
  ));
}
