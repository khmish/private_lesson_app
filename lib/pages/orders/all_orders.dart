import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/lesson_api.dart';
import 'package:private_lesson_app/models/lesson.dart';
import 'package:private_lesson_app/models/user.dart';
import '../../constants/size_const.dart';

class AllordersPage extends StatefulWidget {
  const AllordersPage({Key? key}) : super(key: key);

  @override
  _AllordersPageState createState() => _AllordersPageState();
}

class _AllordersPageState extends State<AllordersPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Lesson> lessons = [];
  User myuser =
      new User(id: -1, name: '', email: '', city: -1, phone: '', gender: '');

  @override
  void initState() {
    super.initState();

    checksIfLogIn().then((user) {
      setState(() {
        myuser = user;
      });
    }).whenComplete(() {
      if (myuser.role == "tutor") {
        LessonAPI.getLessons(teacherId: myuser.id.toString())
            .then((orderlist) {
          setState(() {
            lessons = orderlist;
          });
        });
      } else if (myuser.role == "student") {
        LessonAPI.getLessons(studentId: myuser.id.toString())
            .then((orderlist) {
          setState(() {
            lessons = orderlist;
          });
        });
      } else if (myuser.role == "admin") {
        LessonAPI.getLessons().then((orderlist) {
          setState(() {
            lessons = orderlist;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.max,
      children: [
        SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(30, 40, 30, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Text(
                      'All orders',
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      // width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .7,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 2,
                                  mainAxisExtent: 150),
                          itemCount: lessons.length,
                          itemBuilder: (context, index) {
                            if (lessons[index] != null &&
                                lessons[index].student != null &&
                                lessons[index].teacher != null) {
                              return Container(
                                height: 100,
                                color: Colors.white,
                                child: Card(
                                  elevation: 8,
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: ListTile(
                                                  title: Text(lessons[index]
                                                      .id
                                                      .toString()),
                                                  subtitle: Text(
                                                      "Student name ${lessons[index].student!.name ?? ''} Teacher name ${lessons[index].teacher!.name ?? ''}"),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      child:
                                                          Text("More details"),
                                                      onPressed: () {},
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    // TextButton(
                                                    //   child: Text("ADD TO QUEUE"),
                                                    //   onPressed: (){},
                                                    // ),
                                                    SizedBox(
                                                      width: 8,
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        flex: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                color: Colors.red.shade100,
                                child: Text("no data"),
                              );
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
