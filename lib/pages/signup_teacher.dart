import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/pages/teacher_profile.dart';

class Signup_teacherWidget extends StatefulWidget {
  Signup_teacherWidget({Key? key}) : super(key: key);

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<Signup_teacherWidget> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  User? teacher;
  late List<String> _genderList = ['male', 'female'];
  String _genderSelectedValue = "male";
  late List<City> _cityList = [];
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
          "role": "teacher"
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
        dynamic tachData = response.body;
        teacher = User.fromJson(tachData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Saved"),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => teacher_profile(teacher: teacher,)),
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
                            'Sign UP for Teacher ',
                          ),
                        ),
                        Padding(
                          //------------Name--------------------------
                          padding: EdgeInsetsDirectional.fromSTEB(
                              constLeft, constTop, constRight, constBottom),
                          child: TextFormField(
                            controller: nameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Name',
                              prefixIcon: Icon(
                                Icons.person_outline,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          //------------Email--------------------------
                          padding: EdgeInsetsDirectional.fromSTEB(
                              constLeft, constTop, constRight, constBottom),
                          child: TextFormField(
                            controller: emailController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Email',
                              prefixIcon: Icon(
                                Icons.alternate_email,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          //------------Gender--------------------------
                          padding: EdgeInsetsDirectional.fromSTEB(
                              constLeft, constTop, constRight, constBottom),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: DropdownButtonFormField(
                              value: _genderSelectedValue,
                              onChanged: (newValue) {
                                setState(() {
                                  _genderSelectedValue = newValue.toString();
                                });
                              },
                              items: _genderList.map((String itemList) {
                                return DropdownMenuItem(
                                  child: Text(itemList),
                                  value: itemList,
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                //prefixIcon:Icon(Icons.male),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          //------------Phone--------------------------
                          padding: EdgeInsetsDirectional.fromSTEB(
                              constLeft, constTop, constRight, constBottom),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: phoneController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Phone',
                              prefixIcon: Icon(
                                Icons.phone_android,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          //------------Password--------------------------
                          padding: EdgeInsetsDirectional.fromSTEB(
                              constLeft, constTop, constRight, constBottom),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () =>
                                      passwordVisibility = !passwordVisibility,
                                ),
                                child: Icon(
                                  passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Color(0xFF757575),
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            //------------City--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeft, constTop, constRight, constBottom),
                            child: DropdownButtonFormField(
                              // value: _citySelectedValue,
                              items: _cityList.map((itemList) {
                                print(itemList);
                                return DropdownMenuItem(
                                  child: Text(itemList.name),
                                  value: itemList.id,
                                );
                              }).toList(),
                              onChanged: (cityId) {
                                // log(value);
                                print(cityId);
                                setState(() {
                                  _citySelectedValue = cityId as int;
                                });
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.location_on_rounded),
                                border: const OutlineInputBorder(),
                              ),
                            )),
                        Padding(
                          //------------Register Button--------------------------
                          padding: EdgeInsetsDirectional.fromSTEB(constLeftBtn,
                              constTopBtn, constRightBtn, constBottomBtn),
                          child: SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  isLoading = true;
                                });
                                registed().whenComplete(() {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              },
                              label: Text('Register'),
                              icon: Icon(
                                Icons.create,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   //------------Name--------------------------
                        //   padding: EdgeInsetsDirectional.fromSTEB(
                        //       constLeft, constTop, constRight, constBottom),
                        //   child: TextFormField(
                        //     //change here
                        //     controller: nameController,
                        //     obscureText: false,
                        //     decoration: InputDecoration(
                        //       border: const OutlineInputBorder(),
                        //       labelText: 'Cert',
                        //       prefixIcon: Icon(
                        //         Icons.person_outline,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        //
                        // Padding(
                        //   //------------Name--------------------------
                        //   padding: EdgeInsetsDirectional.fromSTEB(
                        //       constLeft, constTop, constRight, constBottom),
                        //   child: TextFormField(
                        //     //change here
                        //     controller: nameController,
                        //     obscureText: false,
                        //     decoration: InputDecoration(
                        //       border: const OutlineInputBorder(),
                        //       labelText: 'Price',
                        //       // prefixIcon: Icon(
                        //       //   Icons.person_outline,
                        //       // ),
                        //     ),
                        //   ),
                        // ),
                        //
                        // Padding(
                        //   //------------Name--------------------------
                        //   padding: EdgeInsetsDirectional.fromSTEB(
                        //       constLeft, constTop, constRight, constBottom),
                        //   child: TextFormField(
                        //     //change here
                        //     controller: nameController,
                        //     obscureText: false,
                        //     decoration: InputDecoration(
                        //       border: const OutlineInputBorder(),
                        //       labelText: 'Price',
                        //       // prefixIcon: Icon(
                        //       //   Icons.person_outline,
                        //       // ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
