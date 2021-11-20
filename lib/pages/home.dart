import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/pages/orders/myorders_page.dart';
import 'package:private_lesson_app/pages/admin/admin_control.dart';
import 'package:private_lesson_app/pages/main_search.dart';
import 'package:private_lesson_app/pages/myprofile.dart';
import 'package:private_lesson_app/widget/drawer_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';




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

      //here 1
      //bottomNavigationBar: BottomNavigationBar(

    bottomNavigationBar: CurvedNavigationBar(

      //here 2
        //currentIndex: page,

      index: 0,


        onTap: (value) => setState(() => page = value),
        items: [

          //here 3

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: ("Home"),
          // ),


          //here home 7
          //Icon(Icons.home, size: 30),

          //here 4
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.reorder_sharp),
          //   label: ("My Order"),
          // ),

          Icon(Icons.reorder_sharp, size: 30),

          Icon(Icons.home, size: 30),


          //here 5
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.account_circle_rounded),
          //   label: ("My Profile"),
          // ),

          Icon(Icons.account_circle_rounded, size: 30),




        ],

        //here 6
        // type: BottomNavigationBarType.fixed,


      ),
    );
  }
}

Widget getBody(int page) {
  switch (page) {
    case 0:
      //return SearchWidget();

      return MyordersPage();

    case 1:
      //return MyordersPage();
      return SearchWidget();
    default:
      return MyprofileScreen();
  }
}
