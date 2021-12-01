import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/user.dart';
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
  var pages = [
    Icon(Icons.home, size: 30),
  ];
  bool isLoading = true;
  User user = new User(
        id: -1, name: "", email: "", city: -1, phone: "", gender: "", role: "");
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    
    checksIfLogIn().then((userVal) {
      user = userVal;
    }).whenComplete(() {
      if (user.id != -1) {
        if (user.role!.toLowerCase() == "tutor") {
          Navigator.of(context).pushReplacementNamed("/homeTutor");
        } else if (user.role!.toLowerCase() == "admin") {
          Navigator.of(context).pushReplacementNamed("/homeAdmin");
        }
        setState(() {
          pages = [
            Icon(Icons.reorder_sharp, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.account_circle_rounded, size: 30),
          ];

          page = 1;
        });
      } else {
        pages = [
          Icon(Icons.home, size: 30),
        ];
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  int page = 0;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: LinearProgressIndicator(),
          )
        : Scaffold(
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
            drawer: DrawerWidget.drawerWidget(context,user.id!=-1?true:false),
            body: getBody(page, pages,user),

            //here 1
            //bottomNavigationBar: BottomNavigationBar(

            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: colorBackGround,

              // buttonBackgroundColor: colorContainerBox,
              index: page,

              onTap: (value) => setState(() {
                page = value;
              }),
              items: pages,

              //here 6
              // type: BottomNavigationBarType.fixed,
            ),
          );
  }
}

Widget getBody(int page, var pages,User user) {
  switch (page) {
    case 0:
      if (pages.length == 1) {
        return SearchWidget();
      }
      return MyordersPage();

    case 1:
      //return MyordersPage();
      return SearchWidget();

    default:
      return MyprofileScreen(myuser: user,);
  }
}
