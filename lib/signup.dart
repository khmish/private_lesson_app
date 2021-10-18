
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/constants/size_const.dart';

class SignupWidget extends StatefulWidget {
  SignupWidget({Key? key}) : super(key: key);

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
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
    passwordVisibility = false;
    getCities().then((value) {
      setState(() {
        _cityList = value;
        if (_cityList.length > 0) _citySelectedValue = _cityList[0].id;
      });
    });
  }

  var _baseUrlRegisterUser = 'https://privatelesson.herokuapp.com/api/user';
  var _baseUrlCities = 'https://privatelesson.herokuapp.com/api/city';
  Future<void> registed() async {
    var baseUrl = _baseUrlRegisterUser;
    try {
      // if (page > 0) {
      baseUrl = _baseUrlRegisterUser;
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: {
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "gender": _genderSelectedValue,
          "phone": phoneController.text,
          "city_id": _citySelectedValue.toString()
        },
        // headers: <String, String>{
        //   'Accept': 'application/json',
        //   'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $token',
        // },
      );
      print(response.body);
      if (response.statusCode == 200) {
        
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<City>> getCities() async {
    var baseUrl = _baseUrlCities;
    List<City> cityList = [];
    try {
      // if (page > 0) {
      baseUrl = _baseUrlCities;
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
        dynamic body = json.decode(response.body)['data'];

        for (var i = 0; i < body.length; i++) {
          City city = City.fromJson(body[i]);
          cityList.add(city);
        }
        return cityList;
      } else {
        return cityList;
      }
    } catch (e) {
      print(e);
      return cityList;
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Center(
            child: FittedBox(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                      width: MediaQuery.of(context).size.width>1000?MediaQuery.of(context).size.width*0.6:MediaQuery.of(context).size.width ,
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
                        'Sign UP',
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
                            
                            prefixIcon:Icon(Icons.male),
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
                        keyboardType:TextInputType.number,
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
                          onChanged: (value) {
                            // log(value);
                            setState(() {
                              _citySelectedValue = value as int;
                            });
                          },
                          decoration: const InputDecoration(
                            prefixIcon:Icon(Icons.location_on_rounded),
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
                            registed();
                          },
                          label: Text('Register'),
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
