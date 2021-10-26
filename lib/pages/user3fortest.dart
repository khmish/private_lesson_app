
import 'package:private_lesson_app/pages/city.dart';
import 'package:private_lesson_app/pages/main_search.dart';
import 'package:private_lesson_app/pages/user.dart';


import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/api/leveleducation_api.dart';
import 'package:private_lesson_app/api/subject_api.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:private_lesson_app/models/subject.dart';
import 'package:private_lesson_app/models/user.dart';




class MyApp2 extends StatefulWidget {
  final appTitle = 'User Page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
      theme: ThemeData(
        //primaryColor: Color(0xFF6200EE),
        primaryColor: Colors.blue,
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _Row {
  _Row(
      this.valueA,
      this.valueB,
      this.valueC,
      this.valueD,
      );

  final String valueA;
  final String valueB;
  final String valueC;
  final int valueD;

  bool selected = false;
}



class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Header',
                style: textTheme.headline6,
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),


            // ),

            ListTile(
              leading: Icon(Icons.label),
              title: Text('Cities Page'),
              selected: _selectedDestination == 2,
              // onTap: () => selectDestination(2),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CityWidget()),
                  );
                }
            ),



            ListTile(
              leading: Icon(Icons.label),
              title: Text('Users page'),
              selected: _selectedDestination == 2,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchWidget()),
                  );
                }
            ),

            ListTile(
                leading: Icon(Icons.label),
                title: Text('Permissions Page'),
                selected: _selectedDestination == 2,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => userPageWidget()),
                  );
                }
            ),

          ],
        ),
      ),


      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        padding: EdgeInsets.all(20),
        childAspectRatio: 3 / 2,
        children: [

          // PaginatedDataTable(
          //   header: Text('Header Text'),
          //   rowsPerPage: 4,
          //   columns: [
          //     DataColumn(label: Text('Header A')),
          //     DataColumn(label: Text('Header B')),
          //     DataColumn(label: Text('Header C')),
          //     DataColumn(label: Text('Header D')),
          //   ],
          //   source: _DataSource(context),
          // ),


        ],
      ),
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

}
