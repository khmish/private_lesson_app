import 'package:flutter/material.dart';
import 'package:private_lesson_app/signup.dart';
import 'package:private_lesson_app/constants/size_const.dart';

class LoginPageWidget extends StatefulWidget {
  LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late TextEditingController textController1;
  late TextEditingController textController2;
  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordVisibility = false;
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0,0,0,0),
          child: Center(
            child: Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: FittedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width* 0.66,
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 30
                          ),
                        ),
                      ),
                      Padding(//------------Email--------------------------
                        padding: EdgeInsetsDirectional.fromSTEB(constLeft, constTop, constRight, constBottom),
                        child: TextFormField(
                          controller: textController1,
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
                      Padding(//------------Password--------------------------
                        padding: EdgeInsetsDirectional.fromSTEB(constLeft, constTop, constRight, constBottom),
                        child: TextFormField(
                          controller: textController2,
                          obscureText: !passwordVisibility,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
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
                      Padding(//------------Login Button--------------------------
                        padding: EdgeInsetsDirectional.fromSTEB(constLeftBtn, constTopBtn, constRightBtn, constBottomBtn),
                        child: SizedBox(
                          
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton.icon(
                            
                            label: Text("login"),
                            onPressed: () {
                              print('Button pressed ...');
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
      ),
    );
  }
}
