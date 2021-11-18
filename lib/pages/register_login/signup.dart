import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/register.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/widget/form_widget/drp_city_widget.dart';
import 'package:private_lesson_app/widget/form_widget/drp_widget.dart';
import 'package:private_lesson_app/widget/form_widget/pass_text_widget.dart';
import 'package:private_lesson_app/widget/form_widget/text_widget.dart';

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

  //add here
  late User student;

  late List<String> _genderList = ['male', 'female'];
  String _genderSelectedValue = "male";
  late List<City> _cityList = [];
  late int _citySelectedValue = 1;
  late bool passwordVisibility;

  //final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
backgroundColor: (colorBG),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Container(

                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  width: MediaQuery.of(context).size.width > 1000
                      ? MediaQuery.of(context).size.width * 0.6
                      : MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    shape: BoxShape.rectangle,
                    color: (colorAppBar),

                    border: Border.all(
                      color: Color(0xFFA6A4A4),
                      width: 1,
                    ),
                  ),
                  child: Form(
                    key: scaffoldKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: (colorText),
                            ),
                          ),
                        ),
                        //------------Name--------------------------
                        TextWidget.textWidget("Name",
                            length: 70,
                            textController: nameController,
                            icon: Icons.person_outline,
                            keyboardTp: 0),
                        //------------Email--------------------------
                        TextWidget.textWidget("Email",
                            length: 70,
                            textController: emailController,
                            icon: Icons.alternate_email,
                            keyboardTp: 1),
                        //------------Gender--------------------------
                        DrpWidget(
                          listObject: _genderList,
                          selectedValue: _genderSelectedValue,
                          title: "Gender",
                        ),
                        //------------Phone--------------------------
                        TextWidget.textWidget("Phone",
                            length: 10,
                            textController: phoneController,
                            icon: Icons.phone_android,
                            keyboardTp: 2),

                        //------------Password--------------------------
                        PasswordTextWidget(
                            length: 20, textController: passwordController),
                        //------------City--------------------------
                        DrpCityWidget(
                          title: "City",
                          listObject: _cityList,
                          selectedValue: _citySelectedValue,
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
                                if (scaffoldKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  UserAPI.registed(new Register(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          city: _citySelectedValue,
                                          phone: phoneController.text,
                                          gender: _genderSelectedValue,
                                          role: "student"))
                                      .then((value) {
                                    if (value.id != -1) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text("saved!"),
                                        ),
                                      );
                                      Navigator.of(context).popAndPushNamed("/login");
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text("error!!"),
                                        ),
                                      );
                                    }
                                  }).whenComplete(() {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                }
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
    );
  }
}
