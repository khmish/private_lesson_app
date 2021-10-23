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

  bool _checkbox = false;

  late bool switchListTileValue1;
  late bool switchListTileValue2;
  late bool switchListTileValue3;

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
          'Private Lesson',
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


              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                  child: GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      //
                      // DropdownButtonFormField(
                      //   value: _genderSelectedValue,
                      //   items: _genderList.map((String itemList) {
                      //     return DropdownMenuItem(
                      //       child: Text(itemList),
                      //       value: itemList,
                      //     );
                      //   }).toList(),
                      //   onChanged: (newValue) {
                      //     setState(() => _genderSelectedValue = newValue.toString());
                      //   },
                      //   decoration: const InputDecoration(
                      //     border: const OutlineInputBorder(),
                      //   ),
                      // ),
                      // DropdownButtonFormField(
                      //   value: _citySelectedValue,
                      //   items: _cityList.map((itemList) {
                      //     print(itemList);
                      //     return DropdownMenuItem(
                      //       child: Text(itemList.name),
                      //       value: itemList.id,
                      //     );
                      //   }).toList(),
                      //   onChanged: (value) {
                      //     setState(() => _citySelectedValue = value as int);
                      //   },
                      //   decoration: const InputDecoration(
                      //     border: const OutlineInputBorder(),
                      //   ),
                      // ),
                      // DropdownButtonFormField(
                      //   value: _subjectSelectedValue,
                      //   items: _subjectList.map((itemList) {
                      //     print(itemList);
                      //     return DropdownMenuItem(
                      //       child: Text(itemList.name),
                      //       value: itemList.id,
                      //     );
                      //   }).toList(),
                      //   onChanged: (value) {
                      //     setState(() => _subjectSelectedValue = value as int);
                      //   },
                      //   decoration: const InputDecoration(
                      //     border: const OutlineInputBorder(),
                      //   ),
                      // ),
                      // DropdownButtonFormField(
                      //   value: _leveleducationSelectedValue,
                      //   items: _leveleducationList.map((itemList) {
                      //     print(itemList);
                      //     return DropdownMenuItem(
                      //       child: Text(itemList.name),
                      //       value: itemList.id,
                      //     );
                      //   }).toList(),
                      //   onChanged: (value) {
                      //     setState(() => _leveleducationSelectedValue = value as int);
                      //   },
                      //   decoration: const InputDecoration(
                      //     border: const OutlineInputBorder(),
                      //   ),
                      // ),


                    ],
                  ),
                ),
              ),
              Padding(
                // padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
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
                        mainAxisExtent: 100
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
                            children: [
                              ClipRect(
                                child: ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                    sigmaX: 2,
                                    sigmaY: 2,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 5, 5),
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://picsum.photos/seed/305/600',
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 15),
                                      child: Text(
                                          '${_userList[index].name}'
                                      ),
                                    ),
                                    Text(
                                      'id:  ${_userList[index].id}',
                                    )
                                  ],
                                ),
                              ),


                              //permissions

                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    Row(
                                      children: [
                                        Checkbox(
                                          value: _checkbox,
                                          onChanged: (value) {
                                            setState(() {
                                              _checkbox = true;
                                            });
                                          },
                                        ),
                                        Text('Admin'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: _checkbox,
                                          onChanged: (value) {
                                            setState(() {
                                              _checkbox = true;
                                            });
                                          },
                                        ),
                                        Text('Teacher'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: _checkbox,
                                          onChanged: (value) {
                                            setState(() {
                                              _checkbox = true;
                                            });
                                          },
                                        ),
                                        Text('Student'),
                                      ],
                                    ),




                                    // $$$
                                    // Padding(
                                    //   padding: EdgeInsetsDirectional.fromSTEB(
                                    //       0, 0, 0, 15),
                                    //   child: Text(
                                    //     '100\$ /hour',
                                    //   ),
                                    // ),


                                    //permissions
                                    // Row(
                                    //   mainAxisSize: MainAxisSize.max,
                                    //   children: [
                                    //     Icon(
                                    //       Icons.star_rounded,
                                    //       size: 20,
                                    //     ),
                                    //     Icon(
                                    //       Icons.star_rounded,
                                    //       size: 20,
                                    //     ),
                                    //     Icon(
                                    //       Icons.star_rounded,
                                    //       size: 20,
                                    //     ),
                                    //     Icon(
                                    //       Icons.star_rounded,
                                    //       color: Colors.black,
                                    //       size: 20,
                                    //     ),
                                    //     Icon(
                                    //       Icons.star_rounded,
                                    //       color: Colors.black,
                                    //       size: 20,
                                    //     )
                                    //   ],
                                    // ),


                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Divider(thickness: 3, height: 10,)


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