
import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/leveleducation_api.dart';
import 'package:private_lesson_app/api/subject_api.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:private_lesson_app/models/subject.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/widget/select_list_widget.dart';

class teacher_profile extends StatefulWidget {
  late User? teacher;
  teacher_profile({Key? key, this.teacher}) : super(key: key);

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<teacher_profile> {
  late List<Leveleducation> _levelEductionsList = [];
  late List<dynamic> _selectedLevelEductionsList = [];
  late List<Subject> _subjectsList = [];
  late List<dynamic> _selectedSubjectsList = [];
  late TextEditingController titleCertController = new TextEditingController();
  late TextEditingController priceController = new TextEditingController();

  // final scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    SubjectAPI.getSubjects().then((subsList) {
      setState(() {
        _subjectsList = subsList;
      });
    });
    LeveleducationAPI.getLeveleducations().then((levelEdList) {
      setState(() {
        _levelEductionsList = levelEdList;
      });
    });
  }

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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    width: MediaQuery.of(context).size.width > 1000
                        ? MediaQuery.of(context).size.width * 0.6
                        : MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Color(0xFFA6A4A4),
                        width: 1,
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: Text(
                              'Teacher Profile',
                            ),
                          ),
                          Padding(
                            //------------title_cert--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeft, constTop, constRight, constBottom),
                            child: TextFormField(
                              controller: titleCertController,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Your Education',
                                // prefixIcon: Icon(
                                //   Icons.person_outline,
                                // ),
                              ),

                              maxLength: 70,
                              maxLengthEnforced: true,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Education';
                                }
                                return null;
                              },

                            ),
                          ),
                          Padding(
                            //------------Price--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeft, constTop, constRight, constBottom),
                            child: TextFormField(
                              maxLength: 3,
                              maxLengthEnforced: true,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Price';
                                }
                                return null;
                              },

                              controller: priceController,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'price',
                                // prefixIcon: Icon(
                                //   Icons.alternate_email,
                                // ),
                              ),

                              // change here
                              //keyboardType: TextInputType.emailAddress,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Padding(
                            //------------Subject--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeft, constTop, constRight, constBottom),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SelectListWidget(
                                              list: _subjectsList,
                                              callback: (List<dynamic> paralist) {
                                                setState(() {
                                                  _selectedSubjectsList =
                                                      paralist;
                                                });
                                              }),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.subject),
                                    label: Text("Subjects"),
                                  ),
                                ),
                                Row(
                                    children: [
                                      for (var sub in _selectedSubjectsList)
                                        Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 2),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.deepOrangeAccent)),
                                          onPressed: () {},
                                          child: Text(sub.name),
                                        ),
                                      ),
                                    ],
                                    )
                              ],
                            ),
                          ),
                          Padding(
                            //------------Level of Education--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeft, constTop, constRight, constBottom),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SelectListWidget(
                                              list: _levelEductionsList,
                                              callback: (List<dynamic> paralist) {
                                                setState(() {
                                                  _selectedLevelEductionsList =
                                                      paralist;
                                                });
                                              }),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.subject),
                                    label: Text("Level of Educations"),
                                  ),
                                ),
                                Row(
                                  children: [
                                    for (var ed in _selectedLevelEductionsList)
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 2),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.deepOrangeAccent)),
                                          onPressed: () {},
                                          child: Text(ed.name),
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            //------------Register Button--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(constLeftBtn,
                                constTopBtn, constRightBtn, constBottomBtn),
                            child: SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // setState(() {
                                  //   isLoading = true;
                                  // });
                                  // registed().whenComplete(() {
                                  //   setState(() {
                                  //     isLoading = false;
                                  //   });
                                  // });
                                },
                                label: Text('Complete'),
                                icon: Icon(
                                  Icons.create,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
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
