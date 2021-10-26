import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/pages/city.dart';
import 'package:private_lesson_app/pages/edit_user.dart';
import 'package:private_lesson_app/widget/slidable_widget.dart';
import 'package:private_lesson_app/pages/utils.dart';

class UserSlidableWidget extends StatefulWidget {
  UserSlidableWidget({Key? key}) : super(key: key);

  @override
  _UserSlidableWidgetState createState() => _UserSlidableWidgetState();
}

class _UserSlidableWidgetState extends State<UserSlidableWidget> {
  late TextEditingController textController;
  late List<User> _userList = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
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
      body: /*SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [*/

          /*Padding(
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
              ),*/

          ListView.separated(
        itemCount: _userList.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final item = _userList[index];

          return SlidableWidget(
            child: buildListTile(item),
            onDismissed: (action) =>
                dismissSlidableItem(context, index, action),
          );
        },
      ),
      /* ],
          ),
        ),
      ),*/
    );
  }

  void dismissSlidableItem(
      BuildContext context, int index, SlidableAction action) {
    setState(() {
      _userList.removeAt(index);
    });

    switch (action) {
      case SlidableAction.archive:
        Utils.showSnackBar(context, 'Chat has been archived');
        break;
      case SlidableAction.share:
        Utils.showSnackBar(context, 'Chat has been shared');
        break;
      case SlidableAction.more:
        Utils.showSnackBar(context, 'Selected more');
        break;
      case SlidableAction.delete:
        Utils.showSnackBar(context, 'Chat has been deleted');
        break;
    }
  }

  Widget buildListTile(User item) => ListTile(
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
            MaterialPageRoute(
                builder: (context) => edit_user()),
          );
        },
      );
}
