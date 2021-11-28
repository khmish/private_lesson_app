import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/lesson_api.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/lesson.dart';
import 'package:private_lesson_app/models/subject.dart';
import 'package:private_lesson_app/models/tutor_subs_lvl_ed.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/widget/form_widget/drp_sub_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  // widget.tutorsList[index]
  TutorSubsLvEd thisuser;
  DetailScreen({Key? key, required this.thisuser}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isLoading = false;
  int _subjectSelectedValue = 0;
  List<Subject> _subjectslist = [];

  @override
  void initState() {
    super.initState();
    _subjectslist = widget.thisuser.subjects;
    if (_subjectslist.length > 0) {
      _subjectSelectedValue = _subjectslist[0].id!;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    
    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text('profile'),
          backgroundColor: (colorContainerBox),
        ),
        body: isLoading
            ? Center(
                child: LinearProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://picsum.photos/seed/305/600"),
                              fit: BoxFit.cover),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          child: Container(
                            alignment: Alignment(0.0, 2.5),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  //"https://picsum.photos/seed/305/600"
                                  "https://i.ibb.co/JzdX185/profile-male.png"),
                              radius: 60.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        //********************************name************** */
                        'Name: ${widget.thisuser.name}',
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.blueGrey,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        //********************************email************** */
                        'Email: ${widget.thisuser.email}',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        //********************************city************** */
                        'City: ${widget.thisuser.city}',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //********************************Subjects**************
                      DrpSubWidget(
                        defaultValue: _subjectSelectedValue,
                        listObject: _subjectslist,
                        selectedValue: (sub) {
                          setState(() {
                            _subjectSelectedValue = sub;
                          });
                        },
                        title: "Subjects",
                      ),

                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 30),
                          child: ElevatedButton(
                            //********************************Reservation Button************** */
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });
                              print("subject =" +
                                  _subjectSelectedValue.toString());
                              checksIfLogIn().then((value) {
                                if (value.id! > 0 &&
                                    widget.thisuser.id! > 0 &&
                                    _subjectSelectedValue > 0) {
                                  LessonAPI.addLesson(new Lesson(
                                          studentId: value.id!,
                                          teacherId: widget.thisuser.id!,
                                          subjectId: _subjectSelectedValue,
                                          state: "new",
                                          dateExecution:
                                              DateTime.now().toString()))
                                      .then((value) {
                                    if (value.id!=null && value.id! > 0) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text("you are successfully registered for a lesson!!"),
                                        ),
                                      );
                                      Navigator.pop(context, false);
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          "error!!"),
                                    ),
                                  );
                                    }
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          "register first to get the service!!"),
                                    ),
                                  );
                                  Navigator.of(context).pushNamed("/login");
                                }
                              }).whenComplete(() {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            },
                            child: Text(
                              "Request",
                              style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Phone: ${widget.thisuser.phone}',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                     
                    ],
                  ),
                ),
              ));
  }
}
