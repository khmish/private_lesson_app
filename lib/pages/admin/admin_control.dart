// Full control (Admin page)

import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/pages/admin/admin_users.dart';
import 'package:private_lesson_app/pages/admin/admin_cities.dart';
import 'package:private_lesson_app/pages/admin/admin_leveleducations.dart';
import 'package:private_lesson_app/pages/admin/admin_subjects.dart';
import '../../widget/drawer_widget.dart';

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
         backgroundColor: colorBackGround,

      //------------------------------------appBar---------------------------
      appBar: AppBar(
        backgroundColor: (colorContainerBox),
        iconTheme: IconThemeData(color: colorHeaderText),
        automaticallyImplyLeading: true,
        title: Text(
          'Admin Page',
          style: TextStyle(color: colorHeaderText),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),

      //------------------------------------drawer---------------------------
      drawer: DrawerWidget.drawerWidget(context),
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
                        label: Text("Users",style: TextStyle(color: colorPrimaryText  ),),
                        
                        style: ButtonStyle(
                          backgroundColor: _isVisibleUser
                              ? MaterialStateProperty.all<Color>(colorPrimaryBTN)
                              : MaterialStateProperty.all<Color>(
                                  colorSecondaryBTN),
                        ),
                        onPressed: () {
                          showUserPage();
                        },
                        icon: Icon(
                          Icons.person,
                          size: 15,
                        ),
                      ),
                      ElevatedButton.icon(
                        label: Text("Cities",style: TextStyle(color: colorPrimaryText  ),),
                        
                        style: ButtonStyle(
                          backgroundColor: _isVisibleCity
                              ? MaterialStateProperty.all<Color>(colorPrimaryBTN)
                              : MaterialStateProperty.all<Color>(
                                  colorSecondaryBTN),
                        ),
                        onPressed: () {
                          showCityPage();
                        },
                        icon: Icon(
                          Icons.location_city,
                          size: 15,
                        ),
                      ),
                      ElevatedButton.icon(
                        label: Text("Levels education",style: TextStyle(color: colorPrimaryText  ),),
                        
                        style: ButtonStyle(
                          backgroundColor: _isVisibleLevel
                              ? MaterialStateProperty.all<Color>(colorPrimaryBTN)
                              : MaterialStateProperty.all<Color>(
                                  colorSecondaryBTN),
                        ),
                        onPressed: () {
                          showLeveleducationPage();
                        },
                        icon: Icon(
                          Icons.cast_for_education,
                          size: 15,
                        ),
                      ),
                      ElevatedButton.icon(
                        label: Text("Subjects",style: TextStyle(color: colorPrimaryText  ),),
                        
                        style: ButtonStyle(
                          backgroundColor: _isVisibleSubject
                              ? MaterialStateProperty.all<Color>(colorPrimaryBTN)
                              : MaterialStateProperty.all<Color>(
                                  colorSecondaryBTN),
                        ),
                        onPressed: () {
                          showSubjectPage();
                        },
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
