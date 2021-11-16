import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/lesson_api.dart';
import 'package:private_lesson_app/models/lesson.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/pages/main_search.dart';
import '../constants/size_const.dart';

class MyorderPage extends StatefulWidget {
  const MyorderPage({Key? key}) : super(key: key);

  @override
  _MyorderPageState createState() => _MyorderPageState();
}

class _MyorderPageState extends State<MyorderPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController textController;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late List<String> _genderList = ['male', 'female'];
  String _genderSelectedValue = "male";
  late int _citySelectedValue = 1;
  late bool passwordVisibility;

  late TextEditingController cityNameController;
  late TextEditingController countryController;

  late TextEditingController leveleducationNameController;
  late TextEditingController subjectNameController;
  late List<Lesson> lessons = [];
  User myuser =
      new User(id: -1, name: '', email: '', city: -1, phone: '', gender: '');
  //*********  Show/Hide Level education page
  bool _isVisibleLevel = false;
  void showLeveleducationPage() {
    setState(() {
      _isVisibleLevel = !_isVisibleLevel;
    });
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();

    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;

    checksIfLogIn().then((user) {
      setState(() {
        myuser = user;
      });
    }).whenComplete(() {
      if (myuser.role == "tutor") {
        LessonAPI.getLessons(teacher_id: myuser.id.toString())
            .then((orderlist) {
          setState(() {
            lessons = orderlist;
          });
        });
      } else if (myuser.role == "student") {
        LessonAPI.getLessons(student_id: myuser.id.toString())
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
    return Scaffold(
      // key: scaffoldKey,
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   title: Text(
      //     'Private Lesson',
      //   ),
      //   actions: [],
      //   centerTitle: true,
      //   elevation: 4,
      // ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 1000 ? 4 : 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 50),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        //showUserPage();
                      },
                      label: Text('All'),
                      icon: Icon(
                        Icons.subject,
                        size: 15,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // showCityPage();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchWidget()),
                        );
                      },
                      label: Text('New'),
                      icon: Icon(
                        Icons.add,
                        size: 15,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        showLeveleducationPage();
                      },
                      label: Text('Accepted'),
                      icon: Icon(
                        Icons.done,
                        size: 15,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        //showSubjectPage();
                      },
                      label: Text('Canceled'),
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
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
                                                        title: Text(
                                                            lessons[index]
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
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          TextButton(
                                                            child: Text(
                                                                "More details"),
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
                                      color: Colors.red,
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
          ),
        ),
      ),
    );
  }
}
