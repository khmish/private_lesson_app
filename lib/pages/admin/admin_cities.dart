import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/widget/admin_widget/cities_widget.dart';
import 'package:private_lesson_app/widget/slidable_widget.dart';


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

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    cityNameController = TextEditingController();
    countryController = TextEditingController();
    isLoading = true;
    CityAPI.getCities().then((value) {
      setState(() {
        _cityList = value;
      });
    }).whenComplete(() => isLoading = false);
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
              ElevatedButton(
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
                                        maxLength: 22,
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
                                        maxLength: 22,
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
                                          CityAPI.addCities(
                                              cityNameController.text,
                                              countryController.text);
                                          //City tempAddCity = new City(countryName: "", name: "", id: -1);
                                        },
                                        label: Text('Save'),
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
                      }).then((value) {
                    if (value.id != -1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("saved!"),
                        ),
                      );
                      // Navigator.of(context)
                      //     .popAndPushNamed("/login");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("error!!"),
                        ),
                      );
                    }
                  }).whenComplete(() {
                    setState(() {
                      isLoading = false;
                    });
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  // primary: Colors.blue, // <-- Button color
                  // onPrimary: Colors.red, // <-- Splash color
                ),
                child: Icon(Icons.add),
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
      case SlidableAction
          .edit: //*************************** update City ***** */
        countryController.text = _cityList[index].countryName;
        cityNameController.text = _cityList[index].name;
        City tempCity = new City(countryName: "", name: "", id: -1);
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
                              maxLength: 22,
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
                              maxLength: 22,
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
                                EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _cityList[index].countryName =
                                    countryController.text;
                                _cityList[index].name = cityNameController.text;
                                CityAPI.updateACity(_cityList[index])
                                    .then((city) {
                                  tempCity = city;
                                  Navigator.pop(context, false);
                                });
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
            }).then((value) {
          if (tempCity.id == -1) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text("Wrong something!!"),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text("Updated successfully!"),
              ),
            );
          }
        });
        break;

      case SlidableAction
          .delete: //*************************** delete City ***** */
        var tempCity = _cityList.elementAt(index);
        CityAPI.deleteCity(tempCity.id.toString()).then((value) {
          if (value) {
            setState(() {
              _cityList.removeAt(index);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text('Deleted the city ${tempCity.name}'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text("Wrong something!!"),
              ),
            );
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

  //************************************************Build List city
  Widget buildListTileCity(City item) => ListTile(
        // contentPadding: EdgeInsets.symmetric(
        //   horizontal: 16,
        //   vertical: 16,
        // ),
        title: CitiesAdminWidget(
          citiesList: item,
        ),
        onTap: () {},
      );
}
