import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/api/leveleducation_api.dart';
import 'package:private_lesson_app/api/subject_api.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:private_lesson_app/models/subject.dart';
import 'package:private_lesson_app/models/user.dart';

class userPageWidget extends StatefulWidget {
  const userPageWidget({Key? key}) : super(key: key);

  @override
  _userPageWidgetState createState() => _userPageWidgetState();
}

class _userPageWidgetState extends State<userPageWidget> {

  bool _lights = false;

  late String dropDownValue1;
  late List<String> _genderList = ['male', 'female'];
  String _genderSelectedValue = "male";
  late List<City> _cityList = [];
  late int _citySelectedValue = 1;
  late List<Subject> _subjectList = [];
  late int _subjectSelectedValue = 1;
  late List<Leveleducation> _leveleducationList = [];
  late int _leveleducationSelectedValue = 1;
  late List<User> _userList = [];
  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    CityAPI.getCities().then((value) {
      setState(() {
        _cityList = value;
        if (_cityList.length > 0) _citySelectedValue = _cityList[0].id;
      });
    });
    SubjectAPI.getSubjects().then((value) {
      setState(() {
        _subjectList = value;
        if (_subjectList.length > 0) _subjectSelectedValue = _subjectList[0].id;
      });
    });
    LeveleducationAPI.getLeveleducations().then((value) {
      setState(() {
        _leveleducationList = value;
        if (_leveleducationList.length > 0) _leveleducationSelectedValue = _leveleducationList[0].id;
      });
    });
    UserAPI.getUsers().then((value) {
      setState(() {
        _userList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Users',
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
                child: TextFormField(
                  controller: textController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                child: Container(

                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,

                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //3:1 -> 1:1
                        crossAxisCount: MediaQuery.of(context).size.width>1000?1:1,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 2,
                        mainAxisExtent: 200,
                    ),
                    // shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _userList.length,
                    // padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      // 1 ----
                      //

                      return new Column(
                        //return ListTile(
                        // 2---- children: [

                        children: [



                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                           padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      clipBehavior:
                                      Clip.antiAliasWithSaveLayer,
                                      // color: FlutterFlowTheme.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(50),
                                      ),
                                      child: Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            2, 2, 2, 2),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),

                                          child: Image.network(
                                            'https://picsum.photos/seed/305/600',
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(

                                            'Name: ${_userList[index].name}',

                                        ),

                                        // ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(0, 4, 4, 0),
                                            child: Text(

                                              'id:  ${_userList[index].id}',
                                              // columnUsersRecord.email,


                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(0, 4, 4, 0),

                                            child: SwitchListTile(
                                              title: const Text('Admin'),
                                              value: _lights,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  _lights = value;
                                                });
                                              },
                                              secondary: const Icon(Icons.supervised_user_circle),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),

                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(0, 4, 4, 0),

                                            child: SwitchListTile(
                                              title: const Text('Teacher'),
                                              value: _lights,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  _lights = value;
                                                });
                                              },
                                              secondary: const Icon(Icons.supervised_user_circle),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),

                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(0, 4, 4, 0),

                                            child: SwitchListTile(
                                              title: const Text('Student'),
                                              value: _lights,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  _lights = value;
                                                });
                                              },
                                              secondary: const Icon(Icons.supervised_user_circle),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
