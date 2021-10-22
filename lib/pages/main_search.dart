import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/api/subject_api.dart';
import 'package:private_lesson_app/models/subject.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/api/leveleducation_api.dart';
import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/pages/userprofile.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late String dropDownValue1;
  late List<String> _genderList = ['male', 'female'];
  String _genderSelectedValue = "male";
  late List<City> _cityList = [];
  late int _citySelectedValue = 1;
  late List<Subject> _subjectList = [];
  late int _subjectSelectedValue = 1;
  late List<Leveleducation> _leveleducationList = [];
  late int _leveleducationSelectedValue = 1;
  late List<User> _userList = [];
  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    CityAPI.getCities().then((value) {
      setState(() {
        _cityList = value;
        if (_cityList.length > 0) _citySelectedValue = _cityList[0].id;
      });
    });
    SubjectAPI.getSubjects().then((value) {
      setState(() {
        _subjectList = value;
        if (_subjectList.length > 0) _subjectSelectedValue = _subjectList[0].id;
      });
    });
    LeveleducationAPI.getLeveleducations().then((value) {
      setState(() {
        _leveleducationList = value;
        if (_leveleducationList.length > 0)
          _leveleducationSelectedValue = _leveleducationList[0].id;
      });
    });
    UserAPI.getUsers().then((value) {
      setState(() {
        _userList = value;
      });
    });
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
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
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
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                  child: GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      DropdownButtonFormField(
                        value: _genderSelectedValue,
                        items: _genderList.map((String itemList) {
                          return DropdownMenuItem(
                            child: Text(itemList),
                            value: itemList,
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(
                              () => _genderSelectedValue = newValue.toString());
                        },
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      DropdownButtonFormField(
                        value: _citySelectedValue,
                        items: _cityList.map((itemList) {
                          
                          return DropdownMenuItem(
                            child: Text(itemList.name),
                            value: itemList.id,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _citySelectedValue = value as int);
                        },
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      DropdownButtonFormField(
                        value: _subjectSelectedValue,
                        items: _subjectList.map((itemList) {
                          
                          return DropdownMenuItem(
                            child: Text(itemList.name),
                            value: itemList.id,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _subjectSelectedValue = value as int);
                        },
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      DropdownButtonFormField(
                        value: _leveleducationSelectedValue,
                        items: _leveleducationList.map((itemList) {
                          
                          return DropdownMenuItem(
                            child: Text(itemList.name),
                            value: itemList.id,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() =>
                              _leveleducationSelectedValue = value as int);
                        },
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 1000 ? 3 : 1,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 2,
                        mainAxisExtent: 100),
                    // shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _userList.length,
                    // padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return new Column(
                        children: [
                          Expanded(
                            child: ElevatedButton(onPressed: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailScreen(),
                              settings: RouteSettings(arguments: _userList[index])),
                            );
                            },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRect(
                                child: ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                    sigmaX: 2,
                                    sigmaY: 2,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 5, 5),
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://picsum.photos/seed/305/600',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 15),
                                      child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          '${_userList[index].name}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'id:  ${_userList[index].id}',
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 15),
                                      child: Text(
                                        '100\$ /hour',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          color: Colors.black,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Divider(thickness: 3, height: 10,)
                            ),),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final thisuser = ModalRoute.of(context)!.settings.arguments as User;

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "add you image URL here "
                  ),
                  fit: BoxFit.cover
                )
              ),
            child: Container(
              width: double.infinity,
              height: 160,
              child: Container(
                alignment: Alignment(0.0,2.5),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      //"https://picsum.photos/seed/305/600"
                      "https://i.ibb.co/JzdX185/profile-male.png"
                  ),
                  radius: 60.0,
                ),
              ),
            ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              'Name: ${thisuser.name}'
              ,style: TextStyle(
                fontSize: 25.0,
                color:Colors.blueGrey,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400
            ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Email: ${thisuser.email}'
              ,style: TextStyle(
                fontSize: 18.0,
                color:Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300
            ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'City_id: ${thisuser.city}'
              ,style: TextStyle(
                fontSize: 15.0,
                color:Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300
            ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
              elevation: 2.0,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12,horizontal: 30),
                  child: Text("Request",style: TextStyle(
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w300
                  ),))
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Phone: ${thisuser.phone}'
              ,style: TextStyle(
                fontSize: 18.0,
                color:Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300
            ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("Rating",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600
                            ),),
                          SizedBox(
                            height: 7,
                          ),
                          Text("4.0",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w300
                            ),)
                        ],
                      ),
                    ),
                    Expanded(
                      child:
                      Column(
                        children: [
                          Text("Price",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600
                            ),),
                          SizedBox(
                            height: 7,
                          ),
                          Text("100\$ /hour",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w300
                            ),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: (){
                  },
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.pink,Colors.redAccent]
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
                      alignment: Alignment.center,
                      child: Text(
                        "Contact me",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: (){
                  },
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.pink,Colors.redAccent]
                      ),
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
                      alignment: Alignment.center,
                      child: Text(
                        "Favorite",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}