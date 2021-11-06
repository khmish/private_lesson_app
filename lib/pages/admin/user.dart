import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/widget/slidable_widget.dart';
import 'package:private_lesson_app/pages/edit_user.dart';

class UserAdminWidget extends StatefulWidget {
  UserAdminWidget({Key? key}) : super(key: key);

  @override
  _UserAdminWidgetState createState() => _UserAdminWidgetState();
}

class _UserAdminWidgetState extends State<UserAdminWidget> {
  late TextEditingController searchController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late List<String> _genderList = ['male', 'female'];
  String _genderSelectedValue = "male";
  late List<City> _cityList = [];
  late int _citySelectedValue = 1;
  late bool passwordVisibility;
  late List<User> _userList = [];
  late List<String> _roleList = ['student', 'teacher', 'admin'];
  String _roleSelectedValue = "student";

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
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
    isLoading = true;
    UserAPI.getUsers().then((usersList) {
      setState(() {
        _userList = usersList;
      });
    }).whenComplete(() => isLoading = false);
  }

  //****************Add user
  var _baseUrlRegisterUser = 'https://privatelesson.herokuapp.com/api/user';
  // var _baseUrlRegisterUser = 'http://127.0.0.1:8000/api/user';
  Future<void> registed() async {
    var baseUrl = _baseUrlRegisterUser;
    try {
      // if (page > 0) {
      baseUrl = _baseUrlRegisterUser;
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: jsonEncode({
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "gender": _genderSelectedValue,
          "phone": phoneController.text,
          "city_id": _citySelectedValue.toString(),
          "role": _roleSelectedValue,
        }),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Saved"),
            // action: SnackBarAction(
            //   label: 'Action',
            //   onPressed: () {
            //     // Code to execute.
            //   },
            // ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("error!!"),
            // action: SnackBarAction(
            //   label: 'Action',
            //   onPressed: () {
            //     // Code to execute.
            //   },
            // ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: isLoading,
          child: Center(
            child: LinearProgressIndicator(),
          ),
        ),
        Visibility(
          visible: !isLoading,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: TextFormField(
                  controller: searchController,
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
                padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: SingleChildScrollView(
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Positioned(
                                        right: -40.0,
                                        top: -40.0,
                                        child: InkResponse(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: CircleAvatar(
                                            child: Icon(Icons.close),
                                            backgroundColor: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Form(
                                        //key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          //mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              //------------Name--------------------------
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(constLeft, constTop,
                                                      constRight, constBottom),
                                              child: TextFormField(
                                                controller: nameController,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(),
                                                  labelText: 'Name',
                                                  prefixIcon: Icon(
                                                    Icons.person_outline,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              //------------Email--------------------------
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(constLeft, constTop,
                                                      constRight, constBottom),
                                              child: TextFormField(
                                                controller: emailController,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(),
                                                  labelText: 'Email',
                                                  prefixIcon: Icon(
                                                    Icons.alternate_email,
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                              ),
                                            ),
                                            Padding(
                                              //------------Gender--------------------------
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(constLeft, constTop,
                                                      constRight, constBottom),
                                              child: SizedBox(
                                                width: double.infinity,
                                                height: 50,
                                                child: DropdownButtonFormField(
                                                  value: _genderSelectedValue,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _genderSelectedValue =
                                                          newValue.toString();
                                                    });
                                                  },
                                                  items: _genderList
                                                      .map((String itemList) {
                                                    return DropdownMenuItem(
                                                      child: Text(itemList),
                                                      value: itemList,
                                                    );
                                                  }).toList(),
                                                  decoration:
                                                      const InputDecoration(
                                                    prefixIcon:
                                                        Icon(Icons.male),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              //------------Phone--------------------------
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(constLeft, constTop,
                                                      constRight, constBottom),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: phoneController,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(),
                                                  labelText: 'Phone',
                                                  prefixIcon: Icon(
                                                    Icons.phone_android,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              //------------Password--------------------------
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(constLeft, constTop,
                                                      constRight, constBottom),
                                              child: TextFormField(
                                                controller: passwordController,
                                                obscureText:
                                                    !passwordVisibility,
                                                decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(),
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
                                                          ? Icons
                                                              .visibility_outlined
                                                          : Icons
                                                              .visibility_off_outlined,
                                                      color: Color(0xFF757575),
                                                      size: 22,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                //------------City--------------------------
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        constLeft,
                                                        constTop,
                                                        constRight,
                                                        constBottom),
                                                child: DropdownButtonFormField(
                                                  // value: _citySelectedValue,
                                                  items:
                                                      _cityList.map((itemList) {
                                                    print(itemList);
                                                    return DropdownMenuItem(
                                                      child:
                                                          Text(itemList.name),
                                                      value: itemList.id,
                                                    );
                                                  }).toList(),
                                                  onChanged: (cityId) {
                                                    // log(value);
                                                    print(cityId);
                                                    setState(() {
                                                      _citySelectedValue =
                                                          cityId as int;
                                                    });
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    prefixIcon: Icon(Icons
                                                        .location_on_rounded),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                )),
                                            Padding(
                                              //------------Role--------------------------
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(constLeft, constTop,
                                                      constRight, constBottom),
                                              child: SizedBox(
                                                width: double.infinity,
                                                height: 50,
                                                child: DropdownButtonFormField(
                                                  value: _roleSelectedValue,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _roleSelectedValue =
                                                          newValue.toString();
                                                    });
                                                  },
                                                  items: _roleList
                                                      .map((String itemList) {
                                                    return DropdownMenuItem(
                                                      child: Text(itemList),
                                                      value: itemList,
                                                    );
                                                  }).toList(),
                                                  decoration:
                                                      const InputDecoration(
                                                    prefixIcon: Icon(Icons
                                                        .admin_panel_settings),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 5, 10, 0),
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  registed();
                                                },
                                                label: Text('submit'),
                                                icon: Icon(
                                                  Icons.add,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text("Add user"),
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
      ],
    );
  }

  void dismissSlidableItem(
      BuildContext context, int index, SlidableAction action) {
    switch (action) {
      case SlidableAction
          .edit: //*************************** update USER ***** */
        nameController.text = _userList[index].name;
        phoneController.text = _userList[index].phone;
        //_citySelectedValue = _userList[index].city;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    Form(
                      //key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        //mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: TextFormField(
                              controller: nameController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Input name',
                                prefixIcon: Icon(
                                  Icons.text_fields,
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _userList[index].name = nameController.text;
                                _userList[index].phone = phoneController.text;
                                UserAPI.updateUser(_userList[index]);
                              },
                              label: Text('submit'),
                              icon: Icon(
                                Icons.add,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
        break;
      case SlidableAction
          .delete: //*************************** delete USER ***** */
        UserAPI.deleteUser(_userList.elementAt(index).id.toString())
            .then((value) {
          if (value) {
            setState(() {
              _userList.removeAt(index);
            });
            showSnackBar(
                context, 'Deleted the user ${_userList.elementAt(index).name}');
          } else {
            showSnackBar(context, 'something ');
          }
        }).whenComplete(() {});

        break;
    }
  }

  static void showSnackBar(BuildContext context, String message) =>
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );

  //************************************************Build List user
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
}
