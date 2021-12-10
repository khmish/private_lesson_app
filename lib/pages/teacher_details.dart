import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/lesson_api.dart';
import 'package:private_lesson_app/api/tutor_api.dart';
import 'package:private_lesson_app/models/lesson.dart';
import 'package:private_lesson_app/models/subject.dart';
import 'package:private_lesson_app/models/tutor_subs_lvl_ed.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/widget/form_widget/drp_sub_widget.dart';
import 'package:private_lesson_app/widget/form_widget/stars_widget.dart';

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
  TutorSubsLvEd mytutor = TutorSubsLvEd(
      id: -1, tutor_id: -1, levelEductions: [], subjects: [], rating: 0);

  @override
  void initState() {
    super.initState();
    _subjectslist = widget.thisuser.subjects;
    if (_subjectslist.length > 0) {
      _subjectSelectedValue = _subjectslist[0].subject_id!;
    }

    TutorAPI.getATutor(widget.thisuser.id.toString()).then((tutor) {
      setState(() {
        mytutor = tutor;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: (colorContainerBox),
        ),
        backgroundColor: (colorContainerBox),
        body: isLoading
            ? Center(
                child: LinearProgressIndicator(),
              )
            : SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),

                        //------------tutor Pic--------------------------
                        if (widget.thisuser.gender == "male") ...[
                          Container(
                            alignment: Alignment(0.0, 2.5),
                            child: CircleAvatar(
                              child: Image.network(
                                "https://i.ibb.co/JzdX185/profile-male.png",
                              ),
                              backgroundColor: colorPrimaryBTN,
                              radius: 40.0,
                            ),
                          ),
                        ] else ...[
                          Container(
                            alignment: Alignment(0.0, 10.5),
                            child: CircleAvatar(
                              child: Image.network(
                                "https://i.ibb.co/6YtF8h2/profile-female.png",
                              ),
                              backgroundColor: colorPrimaryBTN,
                              radius: 40.0,
                            ),
                          ),
                        ],
                        SizedBox(
                          height: 10,
                        ),

                        Text(
                          //------------tutor name--------------------------
                          '${widget.thisuser.name}',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: colorInputTextBox,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold),
                        ),

                        //------------tutor rating--------------------------
                        Container(
                          alignment: Alignment.center,
                          width: 160,
                          child: StarsWidget.starsWidget(
                              numberOfStars: (mytutor.rating)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 2.0, color: Colors.black12),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        //------------tutor gender--------------------------
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.person_outline,
                                  size: 23,
                                  color: Colors.black87,
                                ),
                                Text(
                                  ' Gender:',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black87,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 2.0, color: Colors.black12),
                            ),
                          ),
                          child: Text(
                            '     ${mytutor.gender}\n',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15.0,
                                color: colorInputTextBox,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        //------------tutor city--------------------------
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.location_city,
                                  size: 23,
                                  color: Colors.black87,
                                ),
                                Text(
                                  ' City:',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black87,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 2.0, color: Colors.black12),
                            ),
                          ),
                          child: Text(
                            '     ${mytutor.city}\n',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15.0,
                                color: colorInputTextBox,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        //------------tutor certification--------------------------
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.cast_for_education_outlined,
                                  size: 20,
                                  color: Colors.black87,
                                ),
                                Text(
                                  ' Scientific certificate:',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black87,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 2.0, color: Colors.black12),
                            ),
                          ),
                          child: Text(
                            '     ${mytutor.cert}\n',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15.0,
                                color: colorInputTextBox,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        //------------tutor experience--------------------------
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.history_edu,
                                  size: 23,
                                  color: Colors.black87,
                                ),
                                Text(
                                  ' Experience:',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black87,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 2.0, color: Colors.black12),
                            ),
                          ),
                          child: Text(
                            '     ${mytutor.exceprience} Years\n',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15.0,
                                color: colorInputTextBox,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        //------------tutor price--------------------------
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.price_change_outlined,
                                  size: 23,
                                  color: Colors.black87,
                                ),
                                Text(
                                  ' Price in hour:',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black87,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 2.0, color: Colors.black12),
                            ),
                          ),
                          child: Text(
                            '     ${mytutor.price}\$\n',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15.0,
                                color: colorInputTextBox,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        //------------tutor subjects--------------------------
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.subject,
                                  size: 23,
                                  color: Colors.black87,
                                ),
                                Text(
                                  ' Subjects:',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black87,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ]),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 2.0, color: Colors.black12),
                            ),
                          ),
                          child: DrpSubWidget(
                            defaultValue: _subjectSelectedValue,
                            listObject: _subjectslist,
                            selectedValue: (sub) {
                              setState(() {
                                _subjectSelectedValue = sub;
                              });
                            },
                            title: "Choose a subject",
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        //------------Reservation Button--------------------------
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 30),
                            child: ElevatedButton(
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
                                      if (value.id != null && value.id! > 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                                "you are successfully registered for a lesson!!"),
                                          ),
                                        );
                                        Navigator.pop(context, false);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text("error!!"),
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
                      ],
                    ),
                  ),
                ),
              ));
  }
}
