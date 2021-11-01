import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/api/leveleducation_api.dart';
import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:private_lesson_app/widget/slidable_widget.dart';
import 'package:private_lesson_app/pages/edit_user.dart';

class LeveleducationAdminWidget extends StatefulWidget {
  LeveleducationAdminWidget({Key? key}) : super(key: key);

  @override
  _LeveleducationAdminWidgetState createState() =>
      _LeveleducationAdminWidgetState();
}

class _LeveleducationAdminWidgetState extends State<LeveleducationAdminWidget> {
  late TextEditingController searchController;
  late TextEditingController leveleducationNameController;
  late List<Leveleducation> _leveleducationList = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    leveleducationNameController = TextEditingController();
    LeveleducationAPI.getLeveleducations().then((value) {
      setState(() {
        _leveleducationList = value;
      });
    });
  }

  //****************Add level education
  var _baseURL1 = 'https://privatelesson.herokuapp.com/api/leveleducation';
  Future<void> addLeveleducations() async {
    var baseUrl = _baseURL1;
    try {
      baseUrl = _baseURL1;
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: {
          "name": leveleducationNameController.text,
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
                                        controller:
                                            leveleducationNameController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText:
                                              'Input Level education name',
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
                                          addLeveleducations();
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
                child: Text("Add level education"),
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
              itemCount: _leveleducationList.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final item = _leveleducationList[index];

                return SlidableWidget(
                  child: buildListTileLeveleducation(item),
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
          _leveleducationList.removeAt(index);
        });
        showSnackBar(context, 'Meshal');
        break;
    }
  }

  static void showSnackBar(BuildContext context, String message) =>
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );

  //************************************************Build List level education
  Widget buildListTileLeveleducation(Leveleducation item) => ListTile(
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
