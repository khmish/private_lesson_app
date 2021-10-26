import 'package:flutter/material.dart';
import 'package:private_lesson_app/pages/edit_user.dart';
import 'package:private_lesson_app/pages/main_search.dart';
import 'package:private_lesson_app/pages/search.dart';
import 'package:private_lesson_app/pages/signup.dart';
import 'package:private_lesson_app/pages/city.dart';
import 'package:private_lesson_app/pages/user3fortest.dart';
import 'package:private_lesson_app/pages/user_slidable.dart';

import 'pages/login.dart';
import 'pages/user.dart';

void main() {
  runApp(MaterialApp(
    // initialRoute: '/',
    //initialRoute: '/user',
    //initialRoute: '/userSlidable',
    //initialRoute: '/edit_user',

    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      //'/': (context) => SearchWidget(),

      '/': (context) => SearchWidget(),
      '/singup': (context) => SignupWidget(),
      '/login': (context) => LoginPageWidget(),
      '/city': (context) => CityWidget(),

      //'/searchPage': (context) => SearchPageWidget(), there is some problem

      '/userSlidable': (context) => UserSlidableWidget(),

      //Permissions
      '/user': (context) => userPageWidget(),
      // '/permissions': (context) => permissions(),

      //Drawer
      '/user2': (context) => MyApp2(),

      //edit page
      '/edituser': (context) => edit_user(),

    },
  ));
}
