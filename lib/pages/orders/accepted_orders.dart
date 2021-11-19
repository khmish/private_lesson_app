import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/lesson_api.dart';
import 'package:private_lesson_app/models/lesson.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/widget/order_widget.dart';
import '../../constants/size_const.dart';

class AcceptedordersPage extends StatefulWidget {
  const AcceptedordersPage({Key? key}) : super(key: key);

  @override
  _AcceptedordersPageState createState() => _AcceptedordersPageState();
}

class _AcceptedordersPageState extends State<AcceptedordersPage> {
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
                      'Accepted orders',
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      // width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .7,
                      child: OrderWidget(ordersList: lessons.where((element) => element.state!.toLowerCase()=='accepted').toList(),),),
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
