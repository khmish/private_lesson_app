import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/lesson_api.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/lesson.dart';
import 'package:private_lesson_app/models/tutor_subs_lvl_ed.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  

  bool isLoading = false;
  var _subjectSelectedValue = 0;
  List<Subjects> _subjectslist = [];

  @override
  Widget build(BuildContext context) {
    final thisuser =
        ModalRoute.of(context)!.settings.arguments as TutorSubsLvEd;
    _subjectslist = thisuser.subjects;
    if (_subjectslist.length > 0) {
      _subjectSelectedValue = _subjectslist[0].subjectId!;
    }
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
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("add you image URL here "),
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
                      'Name: ${thisuser.name}',
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
                      'Email: ${thisuser.email}',
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
                      'City: ${thisuser.city}',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        //********************************Subjects**************
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width > 1000
                            ? MediaQuery.of(context).size.width * .5
                            : MediaQuery.of(context).size.width,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            constLeft, constTop, constRight, constBottom),
                        child: DropdownButtonFormField(
                          value: _subjectSelectedValue,
                          items: _subjectslist.map((itemList) {
                            print(itemList);
                            return DropdownMenuItem(
                              child: Text(itemList.subject!),
                              value: itemList.subjectId,
                            );
                          }).toList(),
                          onChanged: (subjectId) {
                            // log(value);
                            print(subjectId);
                            setState(() {
                              _subjectSelectedValue = subjectId as int;
                            });
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.location_on_rounded),
                            border: const OutlineInputBorder(),
                          ),
                        )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                        child: ElevatedButton(
                          //********************************Reservation Button************** */
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            checksIfLogIn().then((value) {
                              print("subject =" +
                                  _subjectSelectedValue.toString());
                              if (value.id! > 0 &&
                                  thisuser.id! > 0 &&
                                  _subjectSelectedValue > 0) {
                                LessonAPI.addLesson(new Lesson(
                                        studentId: value.id!,
                                        teacherId: thisuser.id!,
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
                      'Phone: ${thisuser.phone}',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Rating",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "4.0",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              //********************************Price************** */

                              child: Column(
                                children: [
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "${thisuser.price} /hour",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      //********************************Contact me Button************** */

                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Colors.pink, Colors.redAccent]),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 100.0,
                                maxHeight: 40.0,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Contact me",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        ),
                        RaisedButton(
                          //********************************Favorite Button************** */

                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Colors.pink, Colors.redAccent]),
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 100.0,
                                maxHeight: 40.0,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Favorite",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ));
  }
}
