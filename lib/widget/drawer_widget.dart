
import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/pages/admin/admin_control.dart';

class DrawerWidget{
  static Widget drawerWidget( BuildContext context){
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
      );
  }
}