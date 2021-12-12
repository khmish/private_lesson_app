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
            //------------user pic--------------------------
            if (user!.gender == "male") ...[
              Container(
                color: colorContainerBox,
                padding: const EdgeInsets.all(6.0),
                //alignment: Alignment.bottomLeft,
                child: CircleAvatar(
                  child: Image.network(
                    "https://i.ibb.co/JzdX185/profile-male.png",
                  ),
                  backgroundColor: colorPrimaryBTN,
                  radius: 30.0,
                ),
              ),
            ] else if (user.gender == "female") ...[
              Container(
                color: colorContainerBox,
                padding: const EdgeInsets.all(6.0),
                //alignment: Alignment.bottomLeft,
                child: CircleAvatar(
                  child: Image.network(
                    "https://i.ibb.co/6YtF8h2/profile-female.png",
                  ),
                  backgroundColor: colorPrimaryBTN,
                  radius: 30.0,
                ),
              ),
            ] else ...[
              Container(
                color: colorContainerBox,
                padding: const EdgeInsets.all(6.0),
                //alignment: Alignment.bottomLeft,
                child: CircleAvatar(
                  backgroundColor: colorPrimaryBTN,
                  radius: 30.0,
                ),
              ),
            ],

            //------------user name--------------------------
            Container(
              color: colorContainerBox,
              padding: const EdgeInsets.all(6.0),
              alignment: Alignment.bottomCenter,
              child: Text(
                '${user.name}',
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),

            //------------drawer list--------------------------
            // isLogin
            //     ? ListTile(
            //         leading: Icon(Icons.label),
            //         title: Text('Chat'),
            //         onTap: () {
            //           Navigator.of(context).popAndPushNamed('/chat');
            //         })
            //     : Text(""),
            isLogin
                ? Text("")
                : ListTile(
                    leading: Icon(Icons.label),
                    title: Text('Teacher Signup'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed('/singupTeacher');
                    }),

            isLogin
                ? Text("")
                : ListTile(
                    leading: Icon(Icons.label),
                    title: Text('Signup'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed('/singup');
                    }),

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
