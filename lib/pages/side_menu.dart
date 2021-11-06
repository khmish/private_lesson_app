import 'package:private_lesson_app/pages/main_search.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  final appTitle = 'User Page';

  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: DrawerWidget(title: appTitle),
      theme: ThemeData(
        //primaryColor: Color(0xFF6200EE),
        primaryColor: Colors.blue,
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}

class DrawerWidget extends StatefulWidget {
  final String title;

  DrawerWidget({Key? key, required this.title}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
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
            ListTile(
                //**************************Users Page ************************/
                leading: Icon(Icons.label),
                title: Text('Users page'),
                selected: _selectedDestination == 2,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchWidget()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
