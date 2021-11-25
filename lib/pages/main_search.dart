import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/api/tutor_search_api.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/api/subject_api.dart';
import 'package:private_lesson_app/models/subject.dart';
import 'package:private_lesson_app/models/tutor_subs_lvl_ed.dart';
import 'package:private_lesson_app/api/leveleducation_api.dart';
import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:private_lesson_app/widget/search_teacher_widget.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  //Bar

  // int _selectedIndex = 0;
 


  late String dropDownValue1;
  late List<String> _genderList = ["", 'male', 'female'];
  String _genderSelectedValue = "";
  late List<City> _cityList = [];
  late int _citySelectedValue = -1;
  late List<Subject> _subjectList = [];
  late int _subjectSelectedValue = -1;
  late List<Leveleducation> _leveleducationList = [];
  late int _leveleducationSelectedValue = -1;
  late List<TutorSubsLvEd> _tutorsList = [];
  late TextEditingController searchController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSearch = false;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    setState(() {
      isLoading = true;
    });
    CityAPI.getCities().then((value) {
      setState(() {
        _cityList = value;
        _cityList.add(new City(id: -1, name: "", countryName: ""));
        // if (_cityList.length > 0) _citySelectedValue = _cityList[0].id;
      });
    });
    SubjectAPI.getSubjects().then((value) {
      setState(() {
        _subjectList = value;
        _subjectList
            .add(new Subject(id: -1, name: "", pic: "", leveleducation: -1));
        // if (_subjectList.length > 0) _subjectSelectedValue = _subjectList[0].id;
      });
    });
    LeveleducationAPI.getLeveleducations().then((value) {
      setState(() {
        _leveleducationList = value;
        _leveleducationList.add(new Leveleducation(id: -1, name: ""));
        // if (_leveleducationList.length > 0)
        //   _leveleducationSelectedValue = _leveleducationList[0].id;
      });
    });

    TutorSearch.searchForTutorsWithParams().then((value) {
      setState(() {
        _tutorsList = value;
      });
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body
      backgroundColor: colorBackGround,
      body: SafeArea(
        //child: _widgetOptions.elementAt[_currentIndex],
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          // color: Colors.blueGrey[50],
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              //*********************************** Search *******************/
              !isSearch
                  ? Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: ElevatedButton(
                        //*********************************** show search *******************/
                        child: Icon(Icons.search_rounded),
                        onPressed: () {
                          setState(() {
                            isSearch = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                      ),
                    )
                  : Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        //color: Colors.white,
                          color:Color(0xff212121),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ElevatedButton(
                              //*********************************** close search *******************/
                              child: Icon(
                                Icons.close,
                              ),
                              onPressed: () {
                                setState(() {
                                  isSearch = false;
                                  // _citySelectedValue = -1;
                                  // _genderSelectedValue = "";
                                  // _leveleducationSelectedValue = -1;
                                  // _subjectSelectedValue = -1;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                              ),
                            ),
                            //*********************************** Search text *******************/

                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                              child: TextFormField(
                                controller: searchController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  prefixIcon: Icon(
                                    Icons.search,
                                  ),
                                ),
                              ),
                            ),
                            //*********************************** Filters *******************/
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: GridView(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            MediaQuery.of(context).size.width >
                                                    1000
                                                ? 4
                                                : 1,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 10,
                                        mainAxisExtent: 50),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: [
                                  //************************************ genders ********************/
                                  DropdownButtonFormField(
                                    value: _genderSelectedValue,
                                    items: _genderList.map((String itemList) {
                                      return DropdownMenuItem(
                                        child: Text(itemList),
                                        value: itemList,
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() => _genderSelectedValue =
                                          newValue.toString());
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'gender',
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                  DropdownButtonFormField(
                                    //************************************cities ********************/
                                    value: _citySelectedValue,
                                    items: _cityList.map((itemList) {
                                      return DropdownMenuItem(
                                        child: Text(itemList.name),
                                        value: itemList.id,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() =>
                                          _citySelectedValue = value as int);
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'city',
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                  DropdownButtonFormField(
                                    //************************************ subjects ********************/
                                    value: _subjectSelectedValue,
                                    items: _subjectList.map((itemList) {
                                      return DropdownMenuItem(
                                        child: Text(itemList.name),
                                        value: itemList.id,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() =>
                                          _subjectSelectedValue = value as int);
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'subject',
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                  DropdownButtonFormField(
                                    //************************************level educations ********************/
                                    value: _leveleducationSelectedValue,
                                    items: _leveleducationList.map((itemList) {
                                      return DropdownMenuItem(
                                        child: Text(itemList.name),
                                        value: itemList.id,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() =>
                                          _leveleducationSelectedValue =
                                              value as int);
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'level education',
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //*********************************** Button controllers *******************/
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //*********************************** clear BUTTON *******************/
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    height: 40,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          _citySelectedValue = -1;
                                          _genderSelectedValue = "";
                                          _leveleducationSelectedValue = -1;
                                          _subjectSelectedValue = -1;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        // textStyle: TextStyle(
                                        //     fontSize: 30, fontWeight: FontWeight.bold)
                                      ),
                                      icon: Icon(Icons.cancel),
                                      label: Text("clear"),
                                    ),
                                  ),
                                  //*********************************** search BUTTON *******************/

                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          isLoading = true;
                                          isSearch = false;
                                        });
                                        print("object");
                                        TutorSearch.searchForTutorsWithParams(
                                                cityId: _citySelectedValue == -1
                                                    ? null
                                                    : _citySelectedValue,
                                                gender: _genderSelectedValue,
                                                leveleducationId:
                                                    _leveleducationSelectedValue ==
                                                            -1
                                                        ? null
                                                        : _leveleducationSelectedValue,
                                                subjectId:
                                                    _subjectSelectedValue == -1
                                                        ? null
                                                        : _subjectSelectedValue)
                                            .then((value) {
                                          setState(() {
                                            _tutorsList = value;
                                          });
                                        }).whenComplete(() {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        });
                                      },
                                      icon: Icon(Icons.search),
                                      label: Text("search"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              //*********************************** Tutors result *******************/
              isLoading
                  ? Center(child: LinearProgressIndicator())
                  : SearchTeacherWidget(
                      tutorsList: _tutorsList,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // //for drawer
  // void selectDestination(int index) {
  //   setState(() {
  //     _selectedDestination = index;
  //   });
  // }
}
