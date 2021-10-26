import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/api/subject_api.dart';
import 'package:private_lesson_app/models/subject.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/api/leveleducation_api.dart';
import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:private_lesson_app/pages/user_slidable.dart';
import 'package:private_lesson_app/pages/userprofile.dart';
import 'package:private_lesson_app/widget/search_teacher_widget.dart';

import 'city.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
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

  int _selectedDestination = 0;

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
        if (_leveleducationList.length > 0)
          _leveleducationSelectedValue = _leveleducationList[0].id;
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
    var textTheme;
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

      //drawer
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
                title: Text('Cities Page'),
                selected: _selectedDestination == 2,
                // onTap: () => selectDestination(2),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CityWidget()),
                  );
                }
            ),



            ListTile(
                leading: Icon(Icons.label),
                title: Text('Users page'),
                selected: _selectedDestination == 2,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserSlidableWidget()),
                  );
                }
            ),

            ListTile(
                leading: Icon(Icons.label),
                title: Text('Permissions Page'),
                selected: _selectedDestination == 2,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserSlidableWidget()),
                  );
                }
            ),

          ],
        ),
      ),



      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
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
                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                          MediaQuery.of(context).size.width > 1000 ? 4 : 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 50
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [//************************************ genders ********************/
                    DropdownButtonFormField(
                      value: _genderSelectedValue,
                      items: _genderList.map((String itemList) {
                        return DropdownMenuItem(
                          child: Text(itemList),
                          value: itemList,
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(
                            () => _genderSelectedValue = newValue.toString());
                      },
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    DropdownButtonFormField(//************************************cities ********************/
                      value: _citySelectedValue,
                      items: _cityList.map((itemList) {
                        return DropdownMenuItem(
                          child: Text(itemList.name),
                          value: itemList.id,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _citySelectedValue = value as int);
                      },
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    DropdownButtonFormField(//************************************ subjects ********************/
                      value: _subjectSelectedValue,
                      items: _subjectList.map((itemList) {
                        return DropdownMenuItem(
                          child: Text(itemList.name),
                          value: itemList.id,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _subjectSelectedValue = value as int);
                      },
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    DropdownButtonFormField(//************************************level educations ********************/
                      value: _leveleducationSelectedValue,
                      items: _leveleducationList.map((itemList) {
                        return DropdownMenuItem(
                          child: Text(itemList.name),
                          value: itemList.id,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() =>
                            _leveleducationSelectedValue = value as int);
                      },
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              SearchTeacherWidget(userList: _userList,),
              ],
          ),
        ),
      ),
    );
  }

  //for drawer
  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

}
