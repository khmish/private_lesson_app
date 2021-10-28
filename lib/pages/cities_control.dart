// Cities control (Admin page)

import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/pages/edit_user.dart';
import 'package:private_lesson_app/widget/slidable_widget.dart';

class CityControlWidget extends StatefulWidget {
  CityControlWidget({Key? key}) : super(key: key);

  @override
  _CityControlWidgetState createState() => _CityControlWidgetState();
}

class _CityControlWidgetState extends State<CityControlWidget> {
  late TextEditingController textController;
  late List<City> _cityList = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Show / Hide input field
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
    CityAPI.getCities().then((value) {
      setState(() {
        _cityList = value;
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
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
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
                      padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                      child: TextFormField(
                        //controller: cityNameController,
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
                      padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                      child: TextFormField(
                        //controller: cityNameController,
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
                      padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          //registed();
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
                padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.separated(
                    itemCount: _cityList.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      final item = _cityList[index];

                      return SlidableWidget(
                        child: buildListTile(item),
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

  Widget buildListTile(City item) => ListTile(
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
