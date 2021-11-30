import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/widget/form_widget/drp_city_widget.dart';
import 'package:private_lesson_app/widget/form_widget/drp_widget.dart';
import 'package:private_lesson_app/widget/form_widget/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyprofileScreen extends StatefulWidget {
  late User myuser;
  MyprofileScreen({Key? key}) : super(key: key);

  @override
  _MyprofileScreenState createState() => _MyprofileScreenState();
}

class _MyprofileScreenState extends State<MyprofileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late List<String> _genderList = ['male', 'female'];
  String _genderSelectedValue = "male";
  late List<City> _cityList = [];
  late int _citySelectedValue = 1;

  bool isLoading = true;
  User myuser =
      new User(id: -1, name: '', email: '', city: -1, phone: '', gender: '');
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    CityAPI.getCities().then((citiesList) {
      setState(() {
        _cityList = citiesList;
        if (_cityList.length > 0) _citySelectedValue = _cityList[0].id;
      });
    });
    setState(() {
      isLoading = true;
    });
    checksIfLogIn().then((value) {
      setState(() {
        myuser = value;
        isLoading = false;
      });
    });
  }

// class MyprofileScreen extends StatelessWidget {
//   MyprofileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.

    nameController.text = myuser.name!;
    _genderSelectedValue = myuser.gender!;
    _citySelectedValue = myuser.city!;
    phoneController.text = myuser.phone!;
    User tempUser = new User(
      name: "",
      gender: "",
      email: "",
      phone: "",
      id: -1,
      city: -1,
    );

    return isLoading == true
        ? Center(
            child: LinearProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: (colorContainerBox),
            // appBar: AppBar(
            //   title: Text('test profile'),
            // ),
            body: SingleChildScrollView(
              child: Center(
                //child: Column(
                child: Form( // del here if som wrong
                  child: Column(
                    children: [
                      //------------Pic user--------------------------
                      Container(
                        width: MediaQuery.of(context).size.width > 1000
                            ? MediaQuery.of(context).size.width * 0.6
                            : MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: colorBackGround,
                            image: DecorationImage(
                                image: NetworkImage("add you image URL here "),
                                fit: BoxFit.cover)),
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          child: Container(
                            alignment: Alignment(0.0, 2.5),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://picsum.photos/seed/305/600"
                                  // "https://i.ibb.co/JzdX185/profile-male.png"
                                  ),
                              radius: 60.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),

                      // //------------Name--------------------------
                      // Padding(
                      //   //------------Name--------------------------
                      //   padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      //   child: TextFormField(
                      //     controller: nameController,
                      //     obscureText: false,
                      //     decoration: InputDecoration(
                      //
                      //       labelText: 'Input name',
                      //       prefixIcon: Icon(
                      //         Icons.text_fields,
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      //------------Name--------------------------
                      TextWidget.textWidget("Name",
                          length: 70,
                          textController: nameController,
                          icon: Icons.person_outline,
                          keyboardTp: 0),


                      //------------Gender--------------------------
                      DrpWidget(
                        listObject: _genderList,
                        defalutValue: _genderSelectedValue,
                        selectedValue: (value) {
                          setState(() {
                            _genderSelectedValue = value;
                            // print(_country);
                          });
                        },
                        title: "Gender",
                      ),

                      //---------------City--------------------------
                      DrpCityWidget(
                        title: "City",
                        listObject: _cityList,
                        defaultValue: _citySelectedValue,
                        selectedValue: (value) {
                          setState(() {
                            _citySelectedValue = value;
                            // print(_country);
                          });
                        },
                      ),


                      //------------Phone--------------------------
                      // Padding(
                      //   //------------Phone--------------------------
                      //   padding: EdgeInsetsDirectional.fromSTEB(
                      //       constLeft, constTop, constRight, constBottom),
                      //   child: TextFormField(
                      //
                      //     keyboardType: TextInputType.number,
                      //     controller: phoneController,
                      //     obscureText: false,
                      //     decoration: InputDecoration(
                      //
                      //       border: const OutlineInputBorder(),
                      //       labelText: 'Phone',
                      //       prefixIcon: Icon(
                      //         Icons.phone_android,
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      //------------Phone--------------------------
                      TextWidget.textWidget("Phone",
                          length: 14,
                          textController: phoneController,
                          icon: Icons.phone_android,
                          keyboardTp: 2),

                      //------------Save button--------------------------
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            myuser.name = nameController.text;
                            myuser.gender = _genderSelectedValue;
                            myuser.city = _citySelectedValue;
                            myuser.phone = phoneController.text;
                            UserAPI.updateUser(myuser).then((user) {
                              tempUser = user;
                            }).then((value) {
                              if (tempUser.id == -1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Wrong something!!"),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Updated successfully!"),
                                  ),
                                );
                              }
                            });
                          },
                          label: Text('Save changes'),
                          icon: Icon(
                            Icons.add,
                            size: 15,
                          ),
                        ),
                      ),

                      // Text(
                      //   'Name: ${myuser.name}',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 25.0,
                      //       color: colorMainText,
                      //       letterSpacing: 2.0,
                      //       fontWeight: FontWeight.w400),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   'Email: ${myuser.email}',
                      //   style: TextStyle(
                      //       fontSize: 18.0,
                      //       color: colorMainText,
                      //       letterSpacing: 2.0,
                      //       fontWeight: FontWeight.w300),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   'Gender: ${myuser.gender}',
                      //   style: TextStyle(
                      //       fontSize: 18.0,
                      //       color: colorMainText,
                      //       letterSpacing: 2.0,
                      //       fontWeight: FontWeight.w300),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   'Phone number: ${myuser.phone}',
                      //   style: TextStyle(
                      //       fontSize: 18.0,
                      //       color: colorMainText,
                      //       letterSpacing: 2.0,
                      //       fontWeight: FontWeight.w300),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   'City: ${myuser.city}',
                      //   style: TextStyle(
                      //       fontSize: 18.0,
                      //       color: colorMainText,
                      //       letterSpacing: 2.0,
                      //       fontWeight: FontWeight.w300),
                      // ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
