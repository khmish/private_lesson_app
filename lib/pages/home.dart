import 'package:flutter/material.dart';
import 'package:private_lesson_app/pages/orders/myorders_page.dart';
import 'package:private_lesson_app/pages/admin/admin_control.dart';
import 'package:private_lesson_app/pages/main_search.dart';
import 'package:private_lesson_app/pages/myorder_page.dart';
import 'package:private_lesson_app/pages/myprofile.dart';
import 'package:private_lesson_app/pages/test_refresh_page/refresh_page.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Private Lesson',
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Header',
                //style: textTheme.headline6,
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),

            // ),

            ListTile(
                leading: Icon(Icons.label),
                title: Text('Admin Control Page'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminControlWidget()),
                  );
                }),

            ListTile(
                leading: Icon(Icons.label),
                title: Text('Teacher Signup'),
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/singupTeacher');
                }),
            ListTile(
                leading: Icon(Icons.label),
                title: Text('Signup'),
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/singup');
                }),
            ListTile(
                leading: Icon(Icons.label),
                title: Text('Login'),
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/login');
                }),
            ListTile(
                leading: Icon(Icons.label),
                title: Text('My Profile'),
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/singup');
                }),
          ],
        ),
      ),
      body: getBody(page),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: (value) => setState(() => page = value),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reorder_sharp),
            title: Text("My Order"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            title: Text("My Profile"),
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
      return ListViewRefreshPage();
    default:
      return MyprofileScreen();
  }
}
