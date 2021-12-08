import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/pages/admin/admin_control.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget {
  static Widget drawerWidget(BuildContext context, bool isLogin, {User? user}) {
    return Drawer(
      child: Container(
        color: colorBackGround,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: colorContainerBox,
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                child: Text(
                  '${user!.name}',
                  //style: textTheme.headline6,
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            isLogin
                ? ListTile(
                    leading: Icon(Icons.label),
                    title: Text('Chat'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed('/chat');
                    })
                : Text(""),
            isLogin
                ? ListTile(
                    leading: Icon(Icons.label),
                    title: Text('Teacher Signup'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed('/singupTeacher');
                    })
                : Text(""),
            isLogin
                ? ListTile(
                    leading: Icon(Icons.label),
                    title: Text('Signup'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed('/singup');
                    })
                : Text(""),
            isLogin
                ? ListTile(
                    leading: Icon(Icons.label),
                    title: Text('Logout'),
                    onTap: () async {
                      final storage = await SharedPreferences.getInstance();
                      storage.remove("token");
                      Navigator.of(context).pushReplacementNamed('/login');
                    })
                : ListTile(
                    leading: Icon(Icons.label),
                    title: Text('Login'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed('/login');
                    }),
          ],
        ),
      ),
    );
  }
}
