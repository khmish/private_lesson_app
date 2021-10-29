// Full control (Admin page)

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/api/leveleducation_api.dart';
import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:private_lesson_app/api/subject_api.dart';
import 'package:private_lesson_app/models/subject.dart';
import 'package:private_lesson_app/pages/edit_user.dart';
import 'package:private_lesson_app/widget/slidable_widget.dart';

class AdminControlWidget extends StatefulWidget {
  AdminControlWidget({Key? key}) : super(key: key);

  @override
  _AdminControlWidgetState createState() => _AdminControlWidgetState();
}

class _AdminControlWidgetState extends State<AdminControlWidget> {
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
  late List<User> _userList = [];

  late TextEditingController cityNameController;
  late TextEditingController countryController;
  late List<City> _cityList = [];

  late TextEditingController leveleducationNameController;
  late List<Leveleducation> _leveleducationList = [];

  late TextEditingController subjectNameController;
  late List<Subject> _subjectList = [];

  //*********  Show/Hide user page
  bool _isVisibleUser = false;
  void showUserPage() {
    setState(() {
      _isVisibleUser = !_isVisibleUser;
    });
  }

  //*********  Show/Hide city page
  bool _isVisibleCity = false;
  void showCityPage() {
    setState(() {
      _isVisibleCity = !_isVisibleCity;
    });
  }

  //*********  Show/Hide Level education page
  bool _isVisibleLevel = false;
  void showLeveleducationPage() {
    setState(() {
      _isVisibleLevel = !_isVisibleLevel;
    });
  }

  //*********  Show/Hide Subject page
  bool _isVisibleSubject = false;
  void showSubjectPage() {
    setState(() {
      _isVisibleSubject = !_isVisibleSubject;
    });
  }

  //*********  Show/Hide input field
  bool _isVisible = false;
  void showInputfield() {
    setState(() {
      _isVisible = !_isVisible;
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
    UserAPI.getUsers().then((value) {
      setState(() {
        _userList = value;
      });
    });

    cityNameController = TextEditingController();
    countryController = TextEditingController();
    CityAPI.getCities().then((value) {
      setState(() {
        _cityList = value;
      });
    });

    leveleducationNameController = TextEditingController();
    LeveleducationAPI.getLeveleducations().then((value) {
      setState(() {
        _leveleducationList = value;
      });
    });

    subjectNameController = TextEditingController();
    SubjectAPI.getSubjects().then((value) {
      setState(() {
        _subjectList = value;
      });
    });
  }

  //****************Add user
  var _baseUrlRegisterUser = 'https://privatelesson.herokuapp.com/api/user';
  Future<void> registed() async {
    var baseUrl = _baseUrlRegisterUser;
    try {
      baseUrl = _baseUrlRegisterUser;
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: {
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "gender": _genderSelectedValue,
          "phone": phoneController.text,
          "city_id": _citySelectedValue.toString()
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  //****************Add city
  var _baseURL = 'https://privatelesson.herokuapp.com/api/city';
  Future<void> addCities() async {
    var baseUrl = _baseURL;
    try {
      baseUrl = _baseURL;
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: {
          "name": cityNameController.text,
          "country_name": countryController.text,
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  //****************Add level education
  var _baseURL1 = 'https://privatelesson.herokuapp.com/api/leveleducation';
  Future<void> addLeveleducations() async {
    var baseUrl = _baseURL1;
    try {
      baseUrl = _baseURL1;
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: {
          "name": leveleducationNameController.text,
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  //****************Add subject
  var _baseURL2 = 'https://privatelesson.herokuapp.com/api/subject';
  Future<void> addsubjects() async {
    var baseUrl = _baseURL2;
    try {
      baseUrl = _baseURL2;
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: {
          "name": subjectNameController.text,
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Private Lesson',
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
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
                        showUserPage();
                      },
                      label: Text('Users'),
                      icon: Icon(
                        Icons.person,
                        size: 15,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        showCityPage();
                      },
                      label: Text('Cities'),
                      icon: Icon(
                        Icons.location_city,
                        size: 15,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        showLeveleducationPage();
                      },
                      label: Text('Levels education'),
                      icon: Icon(
                        Icons.cast_for_education,
                        size: 15,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        showSubjectPage();
                      },
                      label: Text('Subjects'),
                      icon: Icon(
                        Icons.subject,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),

              //**************************************************User Page
              Visibility(
                visible: _isVisibleUser,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: TextFormField(
                        controller: textController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.add),
                            //tooltip: 'Increase user by 1',
                            onPressed: showInputfield,
                          ),
                          Text('Add user')
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _isVisible,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                            ),
                          ),
                          Padding(
                            //------------Password--------------------------
                            padding: EdgeInsetsDirectional.fromSTEB(
                                constLeft, constTop, constRight, constBottom),
                            child: TextFormField(
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
                                // value: _citySelectedValue,
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                registed();
                              },
                              label: Text(''),
                              icon: Icon(
                                Icons.add,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.separated(
                          itemCount: _userList.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            final item = _userList[index];

                            return SlidableWidget(
                              child: buildListTileUser(item),
                              onDismissed: (action) =>
                                  dismissSlidableItem(context, index, action),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //**************************************************City Page
              Visibility(
                visible: _isVisibleCity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: TextFormField(
                        controller: textController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.add),
                            //tooltip: 'Increase city by 1',
                            onPressed: showInputfield,
                          ),
                          Text('Add city')
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _isVisible,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: TextFormField(
                              controller: cityNameController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Input city name',
                                prefixIcon: Icon(
                                  Icons.text_fields,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: TextFormField(
                              controller: countryController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Input country name',
                                prefixIcon: Icon(
                                  Icons.text_fields,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                addCities();
                              },
                              label: Text(''),
                              icon: Icon(
                                Icons.add,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.separated(
                          itemCount: _cityList.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            final item = _cityList[index];

                            return SlidableWidget(
                              child: buildListTileCity(item),
                              onDismissed: (action) =>
                                  dismissSlidableItem(context, index, action),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //**************************************************Level education Page
              Visibility(
                visible: _isVisibleLevel,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: TextFormField(
                        controller: textController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.add),
                            //tooltip: 'Increase level by 1',
                            onPressed: showInputfield,
                          ),
                          Text('Add Level education')
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _isVisible,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: TextFormField(
                              controller: leveleducationNameController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Input Level education name',
                                prefixIcon: Icon(
                                  Icons.text_fields,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                addLeveleducations();
                              },
                              label: Text(''),
                              icon: Icon(
                                Icons.add,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.separated(
                          itemCount: _leveleducationList.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            final item = _leveleducationList[index];

                            return SlidableWidget(
                              child: buildListTileLeveleducation(item),
                              onDismissed: (action) =>
                                  dismissSlidableItem(context, index, action),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //**************************************************subject Page
              Visibility(
                visible: _isVisibleSubject,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: TextFormField(
                        controller: textController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.add),
                            //tooltip: 'Increase subject by 1',
                            onPressed: showInputfield,
                          ),
                          Text('Add Subject')
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _isVisible,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: TextFormField(
                              controller: subjectNameController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Input Subject name',
                                prefixIcon: Icon(
                                  Icons.text_fields,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                addsubjects();
                              },
                              label: Text(''),
                              icon: Icon(
                                Icons.add,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.separated(
                          itemCount: _subjectList.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            final item = _subjectList[index];

                            return SlidableWidget(
                              child: buildListTileSubject(item),
                              onDismissed: (action) =>
                                  dismissSlidableItem(context, index, action),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dismissSlidableItem(
      BuildContext context, int index, SlidableAction action) {
    setState(() {
      _cityList.removeAt(index);
    });

    switch (action) {
      case SlidableAction.edit:
        showSnackBar(context, 'Edited successfully');
        break;
      case SlidableAction.delete:
        showSnackBar(context, 'Deleted successfully');
        break;
    }
  }

  static void showSnackBar(BuildContext context, String message) =>
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );

  //************************************************Build List city
  Widget buildListTileUser(User item) => ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage('https://picsum.photos/seed/305/600'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(item.email)
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditUser()),
          );
        },
      );

  //************************************************Build List city
  Widget buildListTileCity(City item) => ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(item.countryName)
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditUser()),
          );
        },
      );

  //************************************************Build List level education
  Widget buildListTileLeveleducation(Leveleducation item) => ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditUser()),
          );
        },
      );

  //************************************************Build List subject
  Widget buildListTileSubject(Subject item) => ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditUser()),
          );
        },
      );
}
