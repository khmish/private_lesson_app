import 'package:flutter/material.dart';

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/models/city.dart';

import 'package:private_lesson_app/pages/test_refresh_page/refresh_widget.dart';
import 'package:private_lesson_app/pages/main_search.dart';
import 'package:private_lesson_app/widget/slidable_widget.dart';

class ListViewRefreshPage extends StatefulWidget {
  @override
  _ListViewRefreshPageState createState() => _ListViewRefreshPageState();
}

class _ListViewRefreshPageState extends State<ListViewRefreshPage> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  List<int> data = [];

  late TextEditingController searchController;
  late TextEditingController cityNameController;
  late TextEditingController countryController;
  late List<City> _cityList = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadList();
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

  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(milliseconds: 4000));

    final random = Random();
    final data = List.generate(100, (_) => random.nextInt(100));

    setState(() => this.data = data);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Swipe the screen to refresh the page"),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: loadList,
            ),
          ],
        ),
        body: buildList(),
      );

  Widget buildList() => data.isEmpty
      ? Center(child: CircularProgressIndicator())
      : RefreshWidget(
          keyRefresh: keyRefresh,
          onRefresh: loadList,
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
            // child: Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height * 0.8,
            //   child: ListView.separated(
            itemCount: _cityList.length,
            //separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final item = _cityList[index];
              // padding: EdgeInsets.all(16),
              // itemCount: data.length,
              // itemBuilder: (context, index) {
              //   final number = data[index];

              //return buildItem(number);
              return SlidableWidget(
                child: buildListTileCity(item),
                onDismissed: (action) =>
                    dismissSlidableItem(context, index, action),
              );
            },
          ),
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
            MaterialPageRoute(builder: (context) => SearchWidget()),
          );
        },
      );

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

                                // .then((value) {
                                //   if (value) {
                                //     Navigator.pop(context, false);
                                //     showSnackBar(context, 'Updated successfully');
                                //   } else {
                                //     Navigator.pop(context, false);
                                //     showSnackBar(context, 'wrong something');
                                //   }
                                // });
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
            showSnackBar(context, 'wrong something');
          } else {
            showSnackBar(context, 'Updated successfully');
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
            showSnackBar(context, 'Deleted the city ${tempCity.name}');
          } else {
            showSnackBar(context, 'wrong something');
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
}
