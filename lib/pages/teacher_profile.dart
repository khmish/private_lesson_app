import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/widget/select_list_widget.dart';

class teacher_profile extends StatefulWidget {
  late User? teacher;
  teacher_profile({Key? key, this.teacher}) : super(key: key);

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<teacher_profile> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late List<String> _genderList = ['male', 'female'];
  String _genderSelectedValue = "male";
  late List<City> _cityList = [];
  late List<dynamic> _testCitiesList = [];
  late int _citySelectedValue = 1;
  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
    CityAPI.getCities().then((citiesList) {
      setState(() {
        _cityList = citiesList;
        if (_cityList.length > 0) _citySelectedValue = _cityList[0].id;
      });
    });
  }

  var _baseUrlRegisterUser = 'https://privatelesson.herokuapp.com/api/user';
  // var _baseUrlRegisterUser = 'http://127.0.0.1:8000/api/user';
  Future<void> registed() async {
    var baseUrl = _baseUrlRegisterUser;
    try {
      // if (page > 0) {
      baseUrl = _baseUrlRegisterUser;
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: jsonEncode({
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "gender": _genderSelectedValue,
          "phone": phoneController.text,
          "city_id": _citySelectedValue.toString(),
          "role": "student"
        }),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Saved"),
            // action: SnackBarAction(
            //   label: 'Action',
            //   onPressed: () {
            //     // Code to execute.
            //   },
            // ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("error!!"),
            // action: SnackBarAction(
            //   label: 'Action',
            //   onPressed: () {
            //     // Code to execute.
            //   },
            // ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    width: MediaQuery.of(context).size.width > 1000
                        ? MediaQuery.of(context).size.width * 0.6
                        : MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Color(0xFFA6A4A4),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'Teacher Profile',
                          ),
                        ),
                        Padding(
                          //------------Eudcation--------------------------
                          padding: EdgeInsetsDirectional.fromSTEB(
                              constLeft, constTop, constRight, constBottom),
                          child: TextFormField(
                            controller: nameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Your Education',
                              // prefixIcon: Icon(
                              //   Icons.person_outline,
                              // ),
                            ),
                          ),
                        ),
                        Padding(
                          //------------Price--------------------------
                          padding: EdgeInsetsDirectional.fromSTEB(
                              constLeft, constTop, constRight, constBottom),
                          child: TextFormField(
                            controller: emailController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'price',
                              // prefixIcon: Icon(
                              //   Icons.alternate_email,
                              // ),
                            ),

                            // change here
                            //keyboardType: TextInputType.emailAddress,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                            //------------Subject--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeft, constTop, constRight, constBottom),
                            child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.subject),
                                label: Text("Subjects"))),
                        Padding(
                          //------------Level of Education--------------------------
                          padding: EdgeInsetsDirectional.fromSTEB(
                              constLeft, constTop, constRight, constBottom),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectListWidget(
                                      list: _cityList,
                                      callback: (List<dynamic> paralist) {
                                        setState(() {
                                          _testCitiesList = paralist ;
                                        });
                                      }),
                                ),
                              );
                            },
                            icon: Icon(Icons.subject),
                            label: Text("Level of Educations"),
                          ),
                        ),
                        Padding(
                          //------------Register Button--------------------------
                          padding: EdgeInsetsDirectional.fromSTEB(constLeftBtn,
                              constTopBtn, constRightBtn, constBottomBtn),
                          child: SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                for (var item in _testCitiesList) {
                                  print(item.name);
                                }
                                // setState(() {
                                //   isLoading = true;
                                // });
                                // registed().whenComplete(() {
                                //   setState(() {
                                //     isLoading = false;
                                //   });
                                // });
                              },
                              label: Text('Complete'),
                              icon: Icon(
                                Icons.create,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
