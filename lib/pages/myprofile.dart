import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyprofileScreen extends StatefulWidget {
  late User myuser;
  MyprofileScreen({Key? key}) : super(key: key);

  @override
  _MyprofileScreenState createState() => _MyprofileScreenState();
}

class _MyprofileScreenState extends State<MyprofileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = true;
  User myuser =
      new User(id: -1, name: '', email: '', city: -1, phone: '', gender: '');
  @override
  void initState() {
    super.initState();
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
                child: Column(
                  children: [
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
                    Text(
                      'Name: ${myuser.name}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 25.0,
                          color: colorMainText,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Email: ${myuser.email}',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: colorMainText,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Gender: ${myuser.gender}',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: colorMainText,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Phone number: ${myuser.phone}',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: colorMainText,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'City: ${myuser.city}',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: colorMainText,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ));
  }
}
