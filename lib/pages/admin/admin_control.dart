// Full control (Admin page)

import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/pages/admin/admin_users.dart';
import 'package:private_lesson_app/pages/admin/admin_cities.dart';
import 'package:private_lesson_app/pages/admin/admin_leveleducations.dart';
import 'package:private_lesson_app/pages/admin/admin_subjects.dart';

class AdminControlWidget extends StatefulWidget {
  AdminControlWidget({Key? key}) : super(key: key);

  @override
  _AdminControlWidgetState createState() => _AdminControlWidgetState();
}

class _AdminControlWidgetState extends State<AdminControlWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //*********  Show/Hide user page
  bool _isVisibleUser = false;
  void showUserPage() {
    setState(() {
      _isVisibleUser = !_isVisibleUser;
      _isVisibleCity = false;
      _isVisibleLevel = false;
      _isVisibleSubject = false;
    });
  }

  //*********  Show/Hide city page
  bool _isVisibleCity = false;
  void showCityPage() {
    setState(() {
      _isVisibleCity = !_isVisibleCity;
      _isVisibleUser = false;
      _isVisibleLevel = false;
      _isVisibleSubject = false;
    });
  }

  //*********  Show/Hide Level education page
  bool _isVisibleLevel = false;
  void showLeveleducationPage() {
    setState(() {
      _isVisibleLevel = !_isVisibleLevel;
      _isVisibleUser = false;
      _isVisibleCity = false;
      _isVisibleSubject = false;
    });
  }

  //*********  Show/Hide Subject page
  bool _isVisibleSubject = false;
  void showSubjectPage() {
    setState(() {
      _isVisibleSubject = !_isVisibleSubject;
      _isVisibleUser = false;
      _isVisibleCity = false;
      _isVisibleLevel = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
          backgroundColor: (colorAppBar),

      //------------------------------------appBar---------------------------
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Admin Page',
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),

      //------------------------------------drawer---------------------------
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Menue',
                //style: textTheme.headline6,
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
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

      //------------------------------------bady---------------------------
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: SingleChildScrollView(
            child: Column(
              //mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
                  child: GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 1000 ? 4 : 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 50),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: _isVisibleUser
                              ? MaterialStateProperty.all<Color>(Colors.blue)
                              : MaterialStateProperty.all<Color>(
                                  Colors.blue.shade100),
                        ),
                        onPressed: () {
                          showUserPage();
                        },
                        label: Text('Users'),
                        icon: Icon(
                          Icons.person,
                          size: 15,
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: _isVisibleCity
                              ? MaterialStateProperty.all<Color>(Colors.blue)
                              : MaterialStateProperty.all<Color>(
                                  Colors.blue.shade100),
                        ),
                        onPressed: () {
                          showCityPage();
                        },
                        label: Text('Cities'),
                        icon: Icon(
                          Icons.location_city,
                          size: 15,
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: _isVisibleLevel
                              ? MaterialStateProperty.all<Color>(Colors.blue)
                              : MaterialStateProperty.all<Color>(
                                  Colors.blue.shade100),
                        ),
                        onPressed: () {
                          showLeveleducationPage();
                        },
                        label: Text('Levels education'),
                        icon: Icon(
                          Icons.cast_for_education,
                          size: 15,
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: _isVisibleSubject
                              ? MaterialStateProperty.all<Color>(Colors.blue)
                              : MaterialStateProperty.all<Color>(
                                  Colors.blue.shade100),
                        ),
                        onPressed: () {
                          showSubjectPage();
                        },
                        label: Text('Subjects'),
                        icon: Icon(
                          Icons.subject,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),

                //**************************************************User Page
                Visibility(
                  visible: _isVisibleUser,
                  child: UserAdminWidget(),
                ),

                //**************************************************City Page
                Visibility(
                  visible: _isVisibleCity,
                  child: CityAdminWidget(),
                ),

                //**************************************************Level education Page
                Visibility(
                  visible: _isVisibleLevel,
                  child: LeveleducationAdminWidget(),
                ),

                //**************************************************subject Page
                Visibility(
                  visible: _isVisibleSubject,
                  child: SubjectAdminWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
