import 'dart:async';
import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/pages/test_refresh_page//circular_progress.dart';
import 'package:private_lesson_app/pages/test_refresh_page//clipper.dart';
import 'package:private_lesson_app/pages/test_refresh_page/liquid_pull_to_refresh.dart';
import 'package:private_lesson_app/widget/slidable_widget.dart';

class HomeSearchRefresh extends StatefulWidget {
  //final String? title;

  @override
  _HomeSearchRefreshState createState() => _HomeSearchRefreshState();
}

class _HomeSearchRefreshState extends State<HomeSearchRefresh> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  late TextEditingController cityNameController;
  late TextEditingController countryController;
  late List<City> _cityList = [];
  bool isLoading = false;

  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
      Stream<int>.periodic(Duration(seconds: 30), (x) => refreshNum);

  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    //_scrollController = new ScrollController();

    cityNameController = TextEditingController();
    countryController = TextEditingController();
    isLoading = true;
    CityAPI.getCities().then((value) {
      setState(() {
        _cityList = value;
      });
    }).whenComplete(() => isLoading = false);
  }

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    setState(() {
      refreshNum = new Random().nextInt(100);
    });
    return completer.future.then<void>((_) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState!.show();
              })));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Stack(
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
            // Align(alignment: Alignment(-1.0, 0.0), child: Icon(Icons.reorder)),
            // Align(
            //     alignment: Alignment(-0.3, 0.0), child: Text('widget.title!')),
          ],
        ),
      ),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        showChildOpacityTransition: false,
        child: Container(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          //children: [
          //   Padding(
          //     padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: <Widget>[
          //         ElevatedButton(
          //           onPressed: () {
          //             showDialog(
          //                 context: context,
          //                 builder: (BuildContext context) {
          //                   return AlertDialog(
          //                     content: Stack(
          //                       overflow: Overflow.visible,
          //                       children: <Widget>[
          //                         Positioned(
          //                           right: -40.0,
          //                           top: -40.0,
          //                           child: InkResponse(
          //                             onTap: () {
          //                               Navigator.of(context).pop();
          //                             },
          //                             child: CircleAvatar(
          //                               child: Icon(Icons.close),
          //                               backgroundColor: Colors.red,
          //                             ),
          //                           ),
          //                         ),
          //                         Form(
          //                           //key: _formKey,
          //                           child: Column(
          //                             mainAxisSize: MainAxisSize.min,
          //                             //mainAxisSize: MainAxisSize.max,
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.start,
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.center,
          //                             children: [
          //                               Padding(
          //                                 padding:
          //                                     EdgeInsetsDirectional.fromSTEB(
          //                                         10, 0, 10, 0),
          //                                 child: TextFormField(
          //                                   maxLength: 22,
          //                                   controller: cityNameController,
          //                                   obscureText: false,
          //                                   decoration: InputDecoration(
          //                                     labelText: 'Input city name',
          //                                     prefixIcon: Icon(
          //                                       Icons.text_fields,
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ),
          //                               Padding(
          //                                 padding:
          //                                     EdgeInsetsDirectional.fromSTEB(
          //                                         10, 0, 10, 0),
          //                                 child: TextFormField(
          //                                   maxLength: 22,
          //                                   controller: countryController,
          //                                   obscureText: false,
          //                                   decoration: InputDecoration(
          //                                     labelText: 'Input country name',
          //                                     prefixIcon: Icon(
          //                                       Icons.text_fields,
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ),
          //                               Padding(
          //                                 padding:
          //                                     EdgeInsetsDirectional.fromSTEB(
          //                                         10, 5, 10, 0),
          //                                 child: ElevatedButton.icon(
          //                                   onPressed: () {
          //                                     CityAPI.addCities(
          //                                         cityNameController.text,
          //                                         countryController.text);
          //                                     //City tempAddCity = new City(countryName: "", name: "", id: -1);
          //                                   },
          //                                   label: Text('Save'),
          //                                   icon: Icon(
          //                                     Icons.add,
          //                                     size: 15,
          //                                   ),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   );
          //                 }).then((value) {
          //               if (value.id != -1) {
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                   SnackBar(
          //                     backgroundColor: Colors.green,
          //                     content: Text("saved!"),
          //                   ),
          //                 );
          //                 // Navigator.of(context)
          //                 //     .popAndPushNamed("/login");
          //               } else {
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                   SnackBar(
          //                     backgroundColor: Colors.red,
          //                     content: Text("error!!"),
          //                   ),
          //                 );
          //               }
          //             }).whenComplete(() {
          //               setState(() {
          //                 isLoading = false;
          //               });
          //             });
          //           },
          //           style: ElevatedButton.styleFrom(
          //             shape: CircleBorder(),
          //             padding: EdgeInsets.all(20),
          //             // primary: Colors.blue, // <-- Button color
          //             // onPrimary: Colors.red, // <-- Splash color
          //           ),
          //           child: Icon(Icons.add),
          //         ),
          //       ],
          //     ),
          //   ),

          child: StreamBuilder<int>(
              stream: counterStream,
              builder: (context, snapshot) {
                return ListView.builder(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                  itemCount: _cityList.length,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    final item = _cityList[index];
                    //final String item = _items[index];
                    return SlidableWidget(
                      child: buildListTileCity(item),
                      onDismissed: (action) =>
                          dismissSlidableItem(context, index, action),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }

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
        onTap: null,
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
