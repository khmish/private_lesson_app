import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/constants/size_const.dart';

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
  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    getCities().then((value) {
      setState(() {
        _cityList = value;
        if (_cityList.length > 0) _citySelectedValue = _cityList[0].id;
      });
    });
    
  }

  var _baseUrlCities = 'https://privatelesson.herokuapp.com/api/city';

  Future<List<City>> getCities() async {
    var baseUrl = _baseUrlCities;
    List<City> cityList = [];
    try {
      // if (page > 0) {
      baseUrl = _baseUrlCities;
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.get(
        url,
        // headers: <String, String>{
        //   'Accept': 'application/json',
        //   'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $token',
        // },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body)['data'];

        for (var i = 0; i < body.length; i++) {
          City city = City.fromJson(body[i]);
          cityList.add(city);
        }
        return cityList;
      } else {
        return cityList;
      }
    } catch (e) {
      print(e);
      return cityList;
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
                          setState(() => _genderSelectedValue = newValue.toString());
                        },
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      DropdownButtonFormField(
                        value: _citySelectedValue,
                        items: _cityList.map((itemList) {
                            print(itemList);
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
                        value: 'dad',
                        items: []
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() => dropDownValue1 = val.toString());
                        },
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      DropdownButtonFormField(
                        value: 'dad',
                        items: []
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() => dropDownValue1 = val.toString());
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
                      crossAxisCount: MediaQuery.of(context).size.width>1000?3:1,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 2,
                      mainAxisExtent: 100
                    ),
                    // shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 100,
                    // padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
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
                                      child: Text(
                                        'Ali Abudllah',
                                      ),
                                    ),
                                    Text(
                                      'Primary school',
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
