import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/register.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/pages/teacher_profile.dart';
import 'package:private_lesson_app/widget/form_widget/drp_city_widget.dart';
import 'package:private_lesson_app/widget/form_widget/drp_widget.dart';
import 'package:private_lesson_app/widget/form_widget/pass_text_widget.dart';
import 'package:private_lesson_app/widget/form_widget/text_widget.dart';

class SignupTeacherWidget extends StatefulWidget {
  SignupTeacherWidget({Key? key}) : super(key: key);

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupTeacherWidget> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late User teacher;
  late List<String> _genderList = ['male', 'female'];
  String _genderSelectedValue = "male";
  late List<City> _cityList = [];
  late int _citySelectedValue = 1;
  late bool passwordVisibility;

  //final GlobalKey _formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      //key: _formKey,
      backgroundColor: (colorBackGround),

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
                      color: (colorContainerBox),
                      border: Border.all(
                        color: Color(0xFFA6A4A4),
                        width: 1,
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: Text(
                              'Sign UP for Teacher ',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: (colorMainText),
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
                            defalutValue: _genderSelectedValue,
                            selectedValue: (value) {
                              setState(() {
                                _genderSelectedValue = value;
                                // print(_country);
                              });
                            },
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
                            defaultValue: _citySelectedValue,
                            selectedValue: (value) {
                              setState(() {
                                _citySelectedValue = value;
                              });
                            },
                          ),

                          Padding(
                            //------------Register Button--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeftBtn,
                                constTopBtn,
                                constRightBtn,
                                constBottomBtn),
                            child: SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
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
                                            role: "tutor"))
                                        .then((value) {
                                      if (value.id != -1) {
                                        teacher = value;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                teacher_profile(
                                                    teacher: teacher),
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text("Completed!!"),
                                          ),
                                        );
                                      }
                                    }).whenComplete(() {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
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
                                label: Text('Register'),
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
            ),
    );
  }
}
