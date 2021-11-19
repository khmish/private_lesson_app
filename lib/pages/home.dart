import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/pages/orders/myorders_page.dart';
import 'package:private_lesson_app/pages/admin/admin_control.dart';
import 'package:private_lesson_app/pages/main_search.dart';
import 'package:private_lesson_app/pages/myprofile.dart';
import 'package:private_lesson_app/widget/drawer_widget.dart';

class MyHome extends StatefulWidget {
  MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackGround,
      appBar: AppBar(
        backgroundColor: (colorContainerBox),
        iconTheme: IconThemeData(color: colorHeaderText),
        automaticallyImplyLeading: true,
        title: Text(
          'Private Lesson',
          style: TextStyle(color: colorHeaderText),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      drawer: DrawerWidget.drawerWidget(context),
      body: getBody(page),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: (value) => setState(() => page = value),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reorder_sharp),
            label: ("My Order"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: ("My Profile"),
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

Widget getBody(int page) {
  switch (page) {
    case 0:
      return SearchWidget();
    case 1:
      return MyordersPage();
    default:
      return MyprofileScreen();
  }
}
