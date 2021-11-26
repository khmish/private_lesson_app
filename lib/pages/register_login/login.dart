import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/widget/form_widget/pass_text_widget.dart';
import 'package:private_lesson_app/widget/form_widget/text_widget.dart';

class LoginPageWidget extends StatefulWidget {
  LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late bool passwordVisibility;

  // final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;

    checksIfLogIn().then((value) {
      if (value.id != -1) {
        if (value.role!.toLowerCase() == "student") {
          Navigator.of(context).pushReplacementNamed("/home");
        } else if (value.role!.toLowerCase() == "tutor") {
          Navigator.of(context).pushReplacementNamed("/homeTutor");
        } else if (value.role!.toLowerCase() == "admin") {
          Navigator.of(context).pushReplacementNamed("/homeAdmin");
        }
      }
    });
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (colorBackGround),

      //key: scaffoldKey,
      body: _isLoading == true
          ? Center(
              child: LinearProgressIndicator(),
            )
          : Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  width: MediaQuery.of(context).size.width > 1000
                      ? MediaQuery.of(context).size.width * 0.6
                      : MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height * 0.46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    shape: BoxShape.rectangle,
                    color: (colorContainerBox),

                    // border: Border.all(
                    //   width: 1,
                    // ),
                  ),
                  child: Form(
                    key: scaffoldKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // color:colorBox ,
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'Login Page',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: (colorInputTextBox),
                            ),
                          ),
                        ),
                        TextWidget.textWidget('Email',
                            length: 70,
                            textController: emailController,
                            icon: Icons.email),
                        PasswordTextWidget(
                            length: 20, textController: passwordController),
                        Padding(
                          //------------Login Button--------------------------
                          padding: EdgeInsetsDirectional.fromSTEB(
                              constLeftBtn, constTopBtn, constRightBtn, 0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton.icon(
                              label: Text(
                                "login",
                                style: TextStyle(color: colorPrimaryText),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: colorPrimaryBTN,
                              ),
                              onPressed: () {
                                if (scaffoldKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  UserAPI.login(emailController.text,
                                          passwordController.text)
                                      .then((value) {
                                    if (value.id != -1) {
                                      if (value.role!.toLowerCase() ==
                                          "student") {
                                        Navigator.of(context)
                                            .pushReplacementNamed("/home");
                                      } else if (value.role!.toLowerCase() ==
                                          "tutor") {
                                        Navigator.of(context)
                                            .pushReplacementNamed("/homeTutor");
                                      } else if (value.role!.toLowerCase() ==
                                          "admin") {
                                        Navigator.of(context)
                                            .pushReplacementNamed("/homeAdmin");
                                      }
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
                                      _isLoading = false;
                                    });
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.login_outlined,
                                color: colorPrimaryText,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    constLeftBtn, 5, constRightBtn, 0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      primary: colorPrimaryBTN,
                                    ),
                                    icon: Icon(
                                      Icons.wallet_membership,
                                      color: colorPrimaryText,
                                      size: 15,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed("/singup");
                                    },
                                    label: Text(
                                      "regiseter as Student",
                                      style:
                                          TextStyle(color: colorPrimaryText),
                                    ),
                                  ),
                                )),
                            Container(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    constLeftBtn, 5, constRightBtn, 0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      primary: colorPrimaryBTN,
                                    ),
                                    icon: Icon(
                                      Icons.wallet_membership,
                                      color: colorPrimaryText,
                                      size: 15,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              "/singupTeacher");
                                    },
                                    label: Text(
                                      "regiseter as Teacher",
                                      style:
                                          TextStyle(color: colorPrimaryText),
                                    ),
                                  ),
                                )),
                            Container(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    constLeftBtn, 5, constRightBtn, 0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      primary: colorPrimaryBTN,
                                    ),
                                    icon: Icon(
                                      Icons.wallet_membership,
                                      color: colorPrimaryText,
                                      size: 15,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              "/home");
                                    },
                                    label: Text(
                                      "login as Guest",
                                      style:
                                          TextStyle(color: colorPrimaryText),
                                    ),
                                  ),
                                )),
                          ],
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
