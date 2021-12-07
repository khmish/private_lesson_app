import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/api/tutor_api.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:private_lesson_app/models/subject.dart';
import 'package:private_lesson_app/models/tutor.dart';
import 'package:private_lesson_app/models/tutor_subs_lvl_ed.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/widget/form_widget/drp_city_widget.dart';
import 'package:private_lesson_app/widget/form_widget/drp_widget.dart';
import 'package:private_lesson_app/widget/form_widget/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  TutorSubsLvEd mytutor =
      TutorSubsLvEd(id: -1,tutor_id: -1, levelEductions: [], subjects: [], rating: 0);

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
        // if (_cityList.length > 0) _citySelectedValue = _cityList[0].id;
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
    });

    // if (myuser.role!.toLowerCase() == 'tutor') {
    //   setState(() {
    //   isLoading = true;
    // });
    //   TutorAPI.getATutor(widget.myuser.id.toString()).then((tutor) {
    //     setState(() {
    //       mytutor = tutor;
    //       isLoading = false;
    //     });
    //   });
    // }

    myuser = widget.myuser;
    nameController.text = myuser.name!;
    _genderSelectedValue = myuser.gender!;
    _citySelectedValue = myuser.city!;
    phoneController.text = myuser.phone!;

    titleCertController.text = mytutor.cert??"";
    priceController.text = mytutor.price??"";
  }

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
                //child: Column(
                child: Form(
                  // del here if som wrong
                  child: Column(
                    children: [
                      //------------Pic user--------------------------
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
                            // print(_country);
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
                            // print(_country);
                          });
                        },
                      ),

                      //------------Phone--------------------------
                      TextWidget.textWidget("Phone",
                          length: 14,
                          textController: phoneController,
                          icon: Icons.phone_android,
                          keyboardTp: 2),

                      if (mytutor.id != -1) ...[
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

                        // Padding(
                        //   //------------Subject--------------------------
                        //   padding: EdgeInsetsDirectional.fromSTEB(
                        //       constLeft, constTop, constRight, constBottom),
                        //   child: Column(
                        //     children: [
                        //       SizedBox(
                        //         height: 40,
                        //         width: double.infinity,
                        //         child: ElevatedButton.icon(
                        //           onPressed: () {
                        //             Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                 builder: (context) => SelectListWidget(
                        //                     list: _subjectsList,
                        //                     callback: (List<dynamic> paralist) {
                        //                       setState(() {
                        //                         _selectedSubjectsList =
                        //                             paralist;
                        //                       });
                        //                     }),
                        //               ),
                        //             );
                        //           },
                        //           icon: Icon(Icons.subject),
                        //           label: Text("Subjects"),
                        //         ),
                        //       ),
                        //       Row(
                        //         children: [
                        //           for (var sub in _selectedSubjectsList)
                        //             Container(
                        //               margin: EdgeInsets.symmetric(
                        //                   horizontal: 5, vertical: 2),
                        //               child: ElevatedButton(
                        //                 style: ButtonStyle(
                        //                     backgroundColor:
                        //                         MaterialStateProperty.all(
                        //                             Colors.deepOrangeAccent)),
                        //                 onPressed: () {},
                        //                 child: Text(sub.name),
                        //               ),
                        //             ),
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),

                        // Padding(
                        //   //------------Level of Education--------------------------
                        //   padding: EdgeInsetsDirectional.fromSTEB(
                        //       constLeft, constTop, constRight, constBottom),
                        //   child: Column(
                        //     children: [
                        //       SizedBox(
                        //         height: 40,
                        //         width: double.infinity,
                        //         child: ElevatedButton.icon(
                        //           onPressed: () {
                        //             Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                 builder: (context) => SelectListWidget(
                        //                     list: _levelEductionsList,
                        //                     callback: (List<dynamic> paralist) {
                        //                       setState(() {
                        //                         _selectedLevelEductionsList =
                        //                             paralist;
                        //                       });
                        //                     }),
                        //               ),
                        //             );
                        //           },
                        //           icon: Icon(Icons.subject),
                        //           label: Text("Level of Educations"),
                        //         ),
                        //       ),
                        //       Row(
                        //         children: [
                        //           for (var ed in _selectedLevelEductionsList)
                        //             Container(
                        //               margin: EdgeInsets.symmetric(
                        //                   horizontal: 5, vertical: 2),
                        //               child: ElevatedButton(
                        //                 style: ButtonStyle(
                        //                     backgroundColor:
                        //                         MaterialStateProperty.all(
                        //                             Colors.deepOrangeAccent)),
                        //                 onPressed: () {},
                        //                 child: Text(ed.name),
                        //               ),
                        //             ),
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],

                      //------------Save button--------------------------
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            myuser.name = nameController.text;
                            myuser.gender = _genderSelectedValue;
                            myuser.city = _citySelectedValue;
                            myuser.phone = phoneController.text;

                            //--------update cert & price------------------
                            if (mytutor.tutor_id != -1) {
                              mytutor.cert = titleCertController.text;
                              mytutor.price = priceController.text;
                              TutorAPI.updateTutor(new Tutor(id:mytutor.tutor_id ,userId: mytutor.id!, titleCert: mytutor.cert!, price: mytutor.price!, type: "hours"));
                            }

                            UserAPI.updateUser(myuser).then((user) {
                              if (myuser.id == -1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Wrong something!!"),
                                  ),
                                );
                              } else {
                                setState(() {
                                  myuser = user;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Updated successfully!"),
                                  ),
                                );
                              }
                            });
                          },
                          label: Text('Save changes'),
                          icon: Icon(
                            Icons.add,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
