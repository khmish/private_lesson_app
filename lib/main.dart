import 'package:flutter/material.dart';
import 'package:private_lesson_app/pages/home.dart';
import 'package:private_lesson_app/pages/homeAdmin.dart';
import 'package:private_lesson_app/pages/homeTutor.dart';
import 'package:private_lesson_app/pages/homepage1.dart';
import 'package:private_lesson_app/pages/main_search.dart';
import 'package:private_lesson_app/pages/register_login/signup.dart';
import 'package:private_lesson_app/pages/register_login/signup_teacher.dart';
import 'package:private_lesson_app/pages/admin/admin_control.dart';
import 'package:private_lesson_app/pages/myprofile.dart';
import 'package:flutter/services.dart';
import 'package:private_lesson_app/widget/chat/chat_widget.dart';

import 'pages/register_login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MaterialApp(
    //here2
    // initialRoute: '/chat',
    initialRoute: '/login',
    // initialRoute: '/myorder_page',

    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/home': (context) => MyHome(),
      '/homeTutor': (context) => MyHomeTutor(),
      '/homeAdmin': (context) => MyHomeAdmin(),
      '/searchPage': (context) => SearchWidget(),

      '/singupTeacher': (context) => SignupTeacherWidget(),
      // '/': (context) => teacher_profile(),

      '/singup': (context) => SignupWidget(),
      '/login': (context) => LoginPageWidget(),

      //************* Admin Pages *************//
      '/adminControl': (context) => AdminControlWidget(),


      //************* Admin Pages *************//
      '/myprofile': (context) => MyprofileScreen(),

      //************* Teacher Pages *************//
      // '/teacherProfile': (context) => teacher_profile(),

      //Drawer
      '/testRating': (context) => MyHomeTest(),

      '/chat': (context) => ChatWidget(),
    },
  ));
}
