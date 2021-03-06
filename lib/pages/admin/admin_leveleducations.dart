import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/leveleducation_api.dart';
import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:private_lesson_app/widget/admin_widget/subLvl_widget.dart';
import 'package:private_lesson_app/widget/slidable_widget.dart';
import 'package:private_lesson_app/pages/main_search.dart';

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

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    leveleducationNameController = TextEditingController();
    isLoading = true;
    LeveleducationAPI.getLeveleducations().then((value) {
      setState(() {
        _leveleducationList = value;
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
                                        maxLength: 30,
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
                                          LeveleducationAPI.addLeveleducations(
                                              leveleducationNameController
                                                  .text);
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
      case SlidableAction
          .edit: //*************************** update Level education ***** */
        leveleducationNameController.text = _leveleducationList[index].name;
        Leveleducation tempLeveleducation =
            new Leveleducation(name: "", id: -1);
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
                              controller: leveleducationNameController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Input level education name',
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
                                _leveleducationList[index].name =
                                    leveleducationNameController.text;
                                LeveleducationAPI.updateALeveleducation(
                                        _leveleducationList[index])
                                    .then((leveleducation) {
                                  tempLeveleducation = leveleducation;
                                  Navigator.pop(context, false);
                                });
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
          if (tempLeveleducation.id == -1) {
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
          .delete: //*************************** delete Level education ***** */
        var tempLeveleducation = _leveleducationList.elementAt(index);
        LeveleducationAPI.deleteLeveleducation(tempLeveleducation.id.toString())
            .then((value) {
          if (value) {
            setState(() {
              _leveleducationList.removeAt(index);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                    'Deleted the level education ${tempLeveleducation.name}'),
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

  //************************************************Build List level education
  Widget buildListTileLeveleducation(Leveleducation item) => ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        title: ItemAdminWidget(
          itemsList: item,
        ),
        onTap: () {},
      );
}
