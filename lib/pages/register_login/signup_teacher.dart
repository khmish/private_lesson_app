
import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/register.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/pages/teacher_profile.dart';

class SignupTeacherWidget extends StatefulWidget {
  SignupTeacherWidget({Key? key}) : super(key: key);

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupTeacherWidget> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late User teacher;
  late List<String> _genderList = ['male', 'female'];
  String _genderSelectedValue = "male";
  late List<City> _cityList = [];
  late int _citySelectedValue = 1;
  late bool passwordVisibility;

  //final GlobalKey _formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
    CityAPI.getCities().then((citiesList) {
      setState(() {
        _cityList = citiesList;
        if (_cityList.length > 0) _citySelectedValue = _cityList[0].id;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _formKey,
      
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: Text(
                              'Sign UP for Teacher ',
                            ),
                          ),
                          Padding(
                            //------------Name--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeft, constTop, constRight, constBottom),
                            child: TextFormField(
                              controller: nameController,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Name',
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                ),
                              ),

                              maxLength: 70,
                              maxLengthEnforced: true,

                              //
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            //------------Email--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeft, constTop, constRight, constBottom),
                            child: TextFormField(
                              controller: emailController,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Email',
                                prefixIcon: Icon(
                                  Icons.alternate_email,
                                ),
                              ),

                              maxLength: 40,
                              maxLengthEnforced: true,

                              //------------Validate--------------------------
                              validator: (value) {
                                // Check if this field is empty
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }

                                // using regular expression
                                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                  return "Please enter a valid email address";
                                }

                                // the email is valid
                                return null;
                              },

                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            //------------Gender--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeft, constTop, constRight, constBottom),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: DropdownButtonFormField(
                                value: _genderSelectedValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    _genderSelectedValue = newValue.toString();
                                  });
                                },
                                items: _genderList.map((String itemList) {
                                  return DropdownMenuItem(
                                    child: Text(itemList),
                                    value: itemList,
                                  );
                                }).toList(),
                                decoration: const InputDecoration(
                                  //prefixIcon:Icon(Icons.male),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            //------------Phone--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeft, constTop, constRight, constBottom),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: phoneController,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Phone',
                                prefixIcon: Icon(
                                  Icons.phone_android,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                              maxLength: 10,
                              maxLengthEnforced: true,
                            ),
                          ),
                          Padding(
                            //------------Password--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeft, constTop, constRight, constBottom),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid password';
                                }
                                return null;
                              },
                              maxLength: 20,
                              maxLengthEnforced: true,
                              controller: passwordController,
                              obscureText: !passwordVisibility,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Password',
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                ),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => passwordVisibility =
                                        !passwordVisibility,
                                  ),
                                  child: Icon(
                                    passwordVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Color(0xFF757575),
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              //------------City--------------------------
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  constLeft, constTop, constRight, constBottom),
                              child: DropdownButtonFormField(
                                value: _citySelectedValue,
                                items: _cityList.map((itemList) {
                                  print(itemList);
                                  return DropdownMenuItem(
                                    child: Text(itemList.name),
                                    value: itemList.id,
                                  );
                                }).toList(),
                                onChanged: (cityId) {
                                  // log(value);
                                  print(cityId);
                                  setState(() {
                                    _citySelectedValue = cityId as int;
                                  });
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.location_on_rounded),
                                  border: const OutlineInputBorder(),
                                ),
                              )),
                          Padding(
                            //------------Register Button--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeftBtn,
                                constTopBtn,
                                constRightBtn,
                                constBottomBtn),
                            child: SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    UserAPI.registed(new Register(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            city: _citySelectedValue,
                                            phone: phoneController.text,
                                            gender: _genderSelectedValue,
                                            role: "tutor"))
                                        .then((value) {
                                      if (value.id != -1) {
                                        teacher = value;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                teacher_profile(
                                                    teacher: teacher),
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text("Completed!!"),
                                          ),
                                        );
                                      }
                                    }).whenComplete(() {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                  }

                                  // setState(() {
                                  //   isLoading = true;
                                  // });
                                  // registed().whenComplete(() {
                                  //   setState(() {
                                  //     isLoading = false;
                                  //   });
                                  // });
                                },
                                label: Text('Register'),
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
