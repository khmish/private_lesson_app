
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/constants/size_const.dart';

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
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
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
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    width: MediaQuery.of(context).size.width > 1000
                        ? MediaQuery.of(context).size.width * 0.6
                        : MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height * 0.46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: Text(
                              'Login Page',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Padding(
                            //------------Email--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeft, constTop, constRight, constBottom),
                            child: TextFormField(
                              //add here
                              maxLength: 70,
                              maxLengthEnforced: true,

                              //
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },

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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              maxLength: 20,
                              maxLengthEnforced: true,
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
                                // onPressed: () {
                                //   setState(() {
                                //     _isLoading = true;
                                //   });
                                //   UserAPI.login(emailController.text,
                                //           passwordController.text)
                                //       .then((value) {
                                //     if (value) {
                                //       Navigator.of(context).pushNamed("/");
                                //     } else {
                                //       ScaffoldMessenger.of(context).showSnackBar(
                                //         SnackBar(
                                //           backgroundColor: Colors.red,
                                //           content: Text("error!!"),
                                //         ),
                                //       );
                                //     }
                                //   }).whenComplete(() {
                                //     setState(() {
                                //       _isLoading = false;
                                //     });
                                //   });
                                // },

                                onPressed: () {
                                  if (scaffoldKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    UserAPI.login(emailController.text,
                                            passwordController.text)
                                        .then((value) {
                                      if (value) {
                                        Navigator.of(context)
                                            .pushNamed("/home");
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
