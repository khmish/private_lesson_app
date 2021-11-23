import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/lesson_api.dart';
import 'package:private_lesson_app/models/lesson.dart';
import 'package:private_lesson_app/models/user.dart';
import '../constants/size_const.dart';

class MyordersPage extends StatefulWidget {
  const MyordersPage({Key? key}) : super(key: key);

  @override
  _MyordersPageState createState() => _MyordersPageState();
}

class _MyordersPageState extends State<MyordersPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Lesson> lessons = [];
  User myuser =
      new User(id: -1, name: '', email: '', city: -1, phone: '', gender: '');

  //*********  Show/Hide All orders page
  bool _isVisibleAll = false;
  void showAllPage() {
    setState(() {
      _isVisibleAll = !_isVisibleAll;
      _isVisibleAccepted = false;
      _isVisibleNew = false;
      _isVisibleCanceled = false;
    });
  }

  //*********  Show/Hide Accepted orders page
  bool _isVisibleAccepted = false;
  void showAcceptedPage() {
    setState(() {
      _isVisibleAccepted = !_isVisibleAccepted;
      _isVisibleAll = false;
      _isVisibleNew = false;
      _isVisibleCanceled = false;
    });
  }

  //*********  Show/Hide New orders page
  bool _isVisibleNew = false;
  void showNewPage() {
    setState(() {
      _isVisibleNew = !_isVisibleNew;
      _isVisibleAll = false;
      _isVisibleAccepted = false;
      _isVisibleCanceled = false;
    });
  }

  //*********  Show/Hide Canceled orders page
  bool _isVisibleCanceled = false;
  void showCanceledPage() {
    setState(() {
      _isVisibleCanceled = !_isVisibleCanceled;
      _isVisibleAll = false;
      _isVisibleNew = false;
      _isVisibleAccepted = false;
    });
  }

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
                      style: ButtonStyle(
                        backgroundColor: _isVisibleAll
                            ? MaterialStateProperty.all<Color>(Colors.blue)
                            : MaterialStateProperty.all<Color>(
                                Colors.blue.shade100),
                      ),
                      onPressed: () {
                        showAllPage();
                      },
                      label: Text('All'),
                      icon: Icon(
                        Icons.subject,
                        size: 15,
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: _isVisibleNew
                            ? MaterialStateProperty.all<Color>(Colors.blue)
                            : MaterialStateProperty.all<Color>(
                                Colors.blue.shade100),
                      ),
                      onPressed: () {
                        showNewPage();
                      },
                      label: Text('New'),
                      icon: Icon(
                        Icons.add,
                        size: 15,
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: _isVisibleAccepted
                            ? MaterialStateProperty.all<Color>(Colors.blue)
                            : MaterialStateProperty.all<Color>(
                                Colors.blue.shade100),
                      ),
                      onPressed: () {
                        showAcceptedPage();
                      },
                      label: Text('Accepted'),
                      icon: Icon(
                        Icons.done,
                        size: 15,
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: _isVisibleCanceled
                            ? MaterialStateProperty.all<Color>(Colors.blue)
                            : MaterialStateProperty.all<Color>(
                                Colors.blue.shade100),
                      ),
                      onPressed: () {
                        showCanceledPage();
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

              //**************************************************All orders Page
              Visibility(
                visible: _isVisibleAll,
                child: SafeArea(
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
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
              ),

              //**************************************************New orders Page
              Visibility(
                visible: _isVisibleNew,
                child: SafeArea(
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: Text(
                              'New orders',
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
                                      if (lessons[index].state == "new") {
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
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          flex: 5,
                                                          child: ListTile(
                                                            title: Text(lessons[
                                                                    index]
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
                                                                onPressed:
                                                                    () {},
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
              ),

              //**************************************************Accepted orders Page
              Visibility(
                visible: _isVisibleAccepted,
                child: SafeArea(
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: Text(
                              'Accepted orders',
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
                                      if (lessons[index].state == "accepted") {
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
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          flex: 5,
                                                          child: ListTile(
                                                            title: Text(lessons[
                                                                    index]
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
                                                                onPressed:
                                                                    () {},
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
              ),

              //**************************************************Canceled orders Page
              Visibility(
                visible: _isVisibleCanceled,
                child: SafeArea(
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: Text(
                              'Canceled orders',
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
                                      if (lessons[index].state == "canceled") {
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
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          flex: 5,
                                                          child: ListTile(
                                                            title: Text(lessons[
                                                                    index]
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
                                                                onPressed:
                                                                    () {},
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}