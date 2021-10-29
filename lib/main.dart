import 'package:flutter/material.dart';
import 'package:private_lesson_app/pages/edit_user.dart';
import 'package:private_lesson_app/pages/main_search.dart';
import 'package:private_lesson_app/pages/signup.dart';
import 'package:private_lesson_app/pages/city.dart';
import 'package:private_lesson_app/pages/side_menu.dart';
import 'package:private_lesson_app/pages/users_control.dart';
import 'package:private_lesson_app/pages/admin_control.dart';

import 'pages/login.dart';

void main() {
  runApp(MaterialApp(
    // initialRoute: '/',
    //initialRoute: '/user',
    //initialRoute: '/userSlidable',
    //initialRoute: '/edit_user',
    initialRoute: '/cityControl',

    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      //'/': (context) => SearchWidget(),

      '/': (context) => SearchWidget(),
      '/singup': (context) => SignupWidget(),
      '/login': (context) => LoginPageWidget(),
      '/city': (context) => CityWidget(),

      //'/searchPage': (context) => SearchPageWidget(), there is some problem

      //************* Admin Pages
      '/userControl': (context) => UserControlWidget(),
      '/cityControl': (context) => AdminControlWidget(),

      // '/permissions': (context) => permissions(),

      //Drawer
      '/user2': (context) => SideMenu(),

      //edit page
      '/edituser': (context) => EditUser(),
    },
  ));
}
