import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/models/user.dart';

class edit_user extends StatefulWidget {
  const edit_user({Key? key}) : super(key: key);

  @override
  _edit_userState createState() => _edit_userState();
}

class _edit_userState extends State<edit_user> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late List<String> _genderList = ['male', 'female'];
  String _genderSelectedValue = "male";
  late List<City> _cityList = [];
  late int _citySelectedValue = 1;
  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    late List<User> _userList = [];

    passwordVisibility = false;

    CityAPI.getCities().then((citiesList) {
      setState(() {
        _cityList = citiesList;
        if (_cityList.length > 0) _citySelectedValue = _cityList[0].id;
        getUser().then((user) {
          setState(() {
            nameController.text = user.name;
            emailController.text = user.email;
            phoneController.text = user.phone;
            _genderSelectedValue = user.gender;
            _citySelectedValue = user.city;
          });
        });
      });
    });

    // UserAPI.getUsers().then((value) {
    //   setState(() {
    //     _userList = value;
    //   });
    // });
  }

  var _baseUrlGetUser = 'https://privatelesson.herokuapp.com/api/user/1';
  Future<User> getUser() async {
    User user =
        new User(id: -1, name: "", email: "", city: -1, phone: "", gender: "");
    var baseUrl = _baseUrlGetUser;
    try {
      // if (page > 0) {
      baseUrl = _baseUrlGetUser;
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.get(
        url,

        // headers: <String, String>{
        //   'Accept': 'application/json',
        //   'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $token',
        // },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        var body = json.decode(response.body)['data'];
        user = new User.fromJson(body);
        return user;
      } else {
        // print(response.body);
      }
    } catch (e) {
      print(e);
    }
    return user;
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
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Center(
            child: FittedBox(
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
                        'Edit Page',
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
                              () => passwordVisibility = !passwordVisibility,
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
                          value: _citySelectedValue,
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
                            getUser();
                          },
                          label: Text('save edit'),
                          icon: Icon(
                            Icons.create,
                            size: 15,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
