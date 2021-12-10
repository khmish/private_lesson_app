import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/api/leveleducation_api.dart';
import 'package:private_lesson_app/api/subject_api.dart';
import 'package:private_lesson_app/api/tutor_api.dart';
import 'package:private_lesson_app/api/tutor_subs_api.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:private_lesson_app/models/subject.dart';
import 'package:private_lesson_app/models/tutor.dart';
import 'package:private_lesson_app/models/tutor_subs.dart';
import 'package:private_lesson_app/models/tutor_subs_lvl_ed.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/widget/form_widget/drp_city_widget.dart';
import 'package:private_lesson_app/widget/form_widget/drp_widget.dart';
import 'package:private_lesson_app/widget/form_widget/text_widget.dart';
import 'package:private_lesson_app/widget/select_list_widget.dart';

class MyprofileScreen extends StatefulWidget {
  late User myuser;

  MyprofileScreen({Key? key, required this.myuser}) : super(key: key);

  @override
  _MyprofileScreenState createState() => _MyprofileScreenState();
}

class _MyprofileScreenState extends State<MyprofileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;

  late TextEditingController phoneController;

  late List<Leveleducation> _levelEductionsList = [];
  late List<dynamic> _selectedLevelEductionsList = [];
  late List<Subject> _subjectsList = [];
  late List<dynamic> _selectedSubjectsList = [];

  late TextEditingController titleCertController;
  late TextEditingController priceController;

  late List<String> _genderList = ['male', 'female'];
  String _genderSelectedValue = "male";
  late List<City> _cityList = [];
  late int _citySelectedValue = 1;

  bool isLoading = true;
  User myuser =
      new User(id: -1, name: '', email: '', city: -1, phone: "", gender: "");
  TutorSubsLvEd mytutor = TutorSubsLvEd(
      id: -1, tutor_id: -1, levelEductions: [], subjects: [], rating: 0);
  List<TutorSubs> list = <TutorSubs>[];
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();

    titleCertController = TextEditingController();
    priceController = TextEditingController();

    CityAPI.getCities().then((citiesList) {
      setState(() {
        _cityList = citiesList;
      });
    });
    setState(() {
      isLoading = true;
    });
    checksIfLogIn().then((value) {
      setState(() {
        myuser = value;
        isLoading = false;
      });
      if (myuser.role!.toLowerCase() == 'tutor') {
        setState(() {
          isLoading = true;
        });
        SubjectAPI.getSubjects().then((subsList) {
          setState(() {
            _subjectsList = subsList;
          });
        }).whenComplete(() {
          setState(() {
            isLoading = false;
          });
        });
        LeveleducationAPI.getLeveleducations().then((levelEdList) {
          setState(() {
            _levelEductionsList = levelEdList;
          });
        }).whenComplete(() {
          setState(() {
            isLoading = false;
          });
        });
        TutorAPI.getATutor(widget.myuser.id.toString()).then((tutor) {
          setState(() {
            mytutor = tutor;
            isLoading = false;
            titleCertController.text = mytutor.cert ?? "";
            priceController.text = mytutor.price ?? "";
            _selectedSubjectsList = mytutor.subjects;
            _selectedLevelEductionsList = mytutor.levelEductions;
          });
        });
      }
      myuser = widget.myuser;
      nameController.text = myuser.name!;
      _genderSelectedValue = myuser.gender!;
      _citySelectedValue = myuser.city!;
      phoneController.text = myuser.phone!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(
            child: LinearProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: colorBackGround,
            body: SingleChildScrollView(
              child: Center(
                child: Form(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),

                      //------------Pic user--------------------------
                      if (myuser.gender == "male") ...[
                        Container(
                          alignment: Alignment(0.0, 2.5),
                          child: CircleAvatar(
                            child: Image.network(
                              "https://i.ibb.co/JzdX185/profile-male.png",
                            ),
                            backgroundColor: colorPrimaryBTN,
                            radius: 60.0,
                          ),
                        ),
                      ] else ...[
                        Container(
                          alignment: Alignment(0.0, 2.5),
                          child: CircleAvatar(
                            child: Image.network(
                              "https://i.ibb.co/6YtF8h2/profile-female.png",
                            ),
                            backgroundColor: colorPrimaryBTN,
                            radius: 60.0,
                          ),
                        ),
                      ],
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        // width: MediaQuery.of(context).size.width*.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          shape: BoxShape.rectangle,
                          color: (colorContainerBox),

                          // border: Border.all(
                          //   width: 1,
                          // ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                            ),
//------------Name--------------------------
                            TextWidget.textWidget("Name",
                                length: 70,
                                textController: nameController,
                                icon: Icons.person_outline,
                                keyboardTp: 0),

                            //------------Gender--------------------------
                            DrpWidget(
                              listObject: _genderList,
                              defalutValue: _genderSelectedValue,
                              selectedValue: (value) {
                                setState(() {
                                  _genderSelectedValue = value;
                                });
                              },
                              title: "Gender",
                            ),

                            //---------------City--------------------------
                            DrpCityWidget(
                              title: "City",
                              listObject: _cityList,
                              defaultValue: _citySelectedValue,
                              selectedValue: (value) {
                                setState(() {
                                  _citySelectedValue = value;
                                });
                              },
                            ),

                            //------------Phone--------------------------
                            TextWidget.textWidget("Phone",
                                length: 14,
                                textController: phoneController,
                                icon: Icons.phone_android,
                                keyboardTp: 2),

                            if (mytutor.tutor_id != -1) ...[
                              //------------title_cert--------------------------
                              TextWidget.textWidget(
                                "Your Education",
                                length: 70,
                                textController: titleCertController,
                                icon: Icons.cast_for_education_outlined,
                                keyboardTp: 0,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter your Education';
                                //   }
                                //   return null;
                                // },
                              ),

                              //------------Price--------------------------
                              TextWidget.textWidget(
                                "price",
                                length: 3,
                                textController: priceController,
                                icon: Icons.price_change_outlined,
                                keyboardTp: 2,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter your Price';
                                //   }
                                //   return null;
                                // },
                              ),

                              Padding(
                                //------------Subject--------------------------
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    constLeft,
                                    constTop,
                                    constRight,
                                    constBottom),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectListWidget(
                                                      list: _subjectsList,
                                                      callback: (List<dynamic>
                                                          paralist) {
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
                                                          Colors
                                                              .deepOrangeAccent)),
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
                                    constLeft,
                                    constTop,
                                    constRight,
                                    constBottom),
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
                                              builder: (context) =>
                                                  SelectListWidget(
                                                      list: _levelEductionsList,
                                                      callback: (List<dynamic>
                                                          paralist) {
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
                                        for (var ed
                                            in _selectedLevelEductionsList)
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 2),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors
                                                              .deepOrangeAccent)),
                                              onPressed: () {},
                                              child: Text(ed.name),
                                            ),
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                            SizedBox(
                              height: 30,
                            ),

                            //------------Save button--------------------------
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  myuser.name = nameController.text;
                                  myuser.gender = _genderSelectedValue;
                                  myuser.city = _citySelectedValue;
                                  myuser.phone = phoneController.text;

                                  //--------update cert & price------------------------------
                                  if (mytutor.tutor_id != -1) {
                                    mytutor.cert = titleCertController.text;
                                    mytutor.price = priceController.text;
                                    TutorAPI.updateTutor(new Tutor(
                                        id: mytutor.tutor_id,
                                        userId: mytutor.id!,
                                        titleCert: mytutor.cert!,
                                        price: mytutor.price!,
                                        type: "hours"));

                                    //--------update subjects tutor----------------------------
                                    for (var i = 0;
                                        i < _selectedSubjectsList.length;
                                        i++) {
                                      await TutorSubsAPI.addTutorSubs(
                                          new TutorSubs(
                                              tutorId: mytutor.tutor_id!,
                                              subjectId:
                                                  _selectedSubjectsList[i]
                                                          .subject_id ??
                                                      _selectedSubjectsList[i]
                                                          .id));
                                    }
                                  }

                                  UserAPI.updateUser(myuser).then((user) {
                                    if (myuser.id == -1) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text("Wrong something!!"),
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        myuser = user;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          content:
                                              Text("Updated successfully!"),
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: Text('Save changes'),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
