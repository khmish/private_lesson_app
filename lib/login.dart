import 'package:flutter/material.dart';
import 'package:private_lesson_app/signup.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'city.dart';

class LoginPageWidget extends StatefulWidget {
  LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  bool _isLoading = false;
  var _baseUrlLogin = "https://privatelesson.herokuapp.com/api/user/login";
  Future<void> login() async {
    setState(() {
      _isLoading = true;
    });
    var baseUrl = _baseUrlLogin;
    try {
      // if (page > 0) {
      baseUrl = _baseUrlLogin;
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: {
          "email": emailController.text,
          "password": passwordController.text,
        },
        // headers: <String, String>{
        //   'Accept': 'application/json',
        //   'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $token',
        // },
      );
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CityWidget()),
        );
      } else {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content:  Text("invlid password or username"),
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
      backgroundColor: Color(0xFFF5F5F5),
      body: _isLoading == true
          ? Center(
              child: LinearProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Center(
                  child: FittedBox(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                      width: MediaQuery.of(context).size.width>1000?MediaQuery.of(context).size.width*0.6:MediaQuery.of(context).size.width ,
                      // height: MediaQuery.of(context).size.height * 0.46,
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 30),
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
                                labelText: 'Email',
                                border: const OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.alternate_email,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
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
                                labelText: 'Password',
                                border: const OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                ),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => passwordVisibility =
                                        !passwordVisibility,
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
                            //------------Login Button--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeftBtn,
                                constTopBtn,
                                constRightBtn,
                                constBottomBtn),
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton.icon(
                                label: Text("login"),
                                onPressed: () {
                                  login().whenComplete(() {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  });
                                },
                                icon: Icon(
                                  Icons.login_outlined,
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
