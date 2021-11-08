import 'package:flutter/material.dart';
import 'package:private_lesson_app/pages/main_search.dart';
import 'package:private_lesson_app/pages/myorder_page.dart';
import 'package:private_lesson_app/pages/signup.dart';
import 'package:private_lesson_app/pages/side_menu.dart';
import 'package:private_lesson_app/pages/signup_teacher.dart';
import 'package:private_lesson_app/pages/teacher_profile.dart';
import 'package:private_lesson_app/pages/admin/admin_control.dart';

import 'pages/login.dart';

void main() {
  runApp(MaterialApp(
    // initialRoute: '/',
    //initialRoute: '/user',
    //initialRoute: '/userSlidable',
    //initialRoute: '/edit_user',
    initialRoute: '/searchPage',

    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/searchPage': (context) => SearchWidget(),

      '/singupTeacher': (context) => Signup_teacherWidget(),
      // '/': (context) => teacher_profile(),

      '/singup': (context) => SignupWidget(),
      '/login': (context) => LoginPageWidget(),

      //************* Admin Pages *************//
      '/adminControl': (context) => AdminControlWidget(),

      //************* Student Pages *************//
      '/myorder_page': (context) => myorder_page(),

      //Drawer
      '/user2': (context) => SideMenu(),
    },
  ));
}
