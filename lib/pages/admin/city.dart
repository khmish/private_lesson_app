import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/widget/slidable_widget.dart';
import 'package:private_lesson_app/pages/edit_user.dart';

class CityAdminWidget extends StatefulWidget {
  CityAdminWidget({Key? key}) : super(key: key);

  @override
  _CityAdminWidgetState createState() => _CityAdminWidgetState();
}

class _CityAdminWidgetState extends State<CityAdminWidget> {
  late TextEditingController searchController;
  late TextEditingController cityNameController;
  late TextEditingController countryController;
  late List<City> _cityList = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    cityNameController = TextEditingController();
    countryController = TextEditingController();
    CityAPI.getCities().then((value) {
      setState(() {
        _cityList = value;
      });
    });
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

  // delete city*****************************************************
  var _baseDeleteURL = 'https://privatelesson.herokuapp.com/api/city';
  Future<void> deleteCities() async {
    var baseDeleteUrl = _baseDeleteURL;
    try {
      baseDeleteUrl = _baseDeleteURL;
      var url = Uri.parse(baseDeleteUrl);
      var response = await http.delete(
        url,
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
    return Column(
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          addCities();
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
                },
                child: Text("Add city"),
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
    );
  }

  void dismissSlidableItem(
      BuildContext context, int index, SlidableAction action) {
    switch (action) {
      case SlidableAction.edit:
        showSnackBar(context, 'Edited successfully');
        break;
      case SlidableAction.delete:
        setState(() {
          deleteCities();
          _cityList.removeAt(index);
        });
        showSnackBar(context, 'Done ...');
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
}
