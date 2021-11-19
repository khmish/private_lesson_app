import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/api/subject_api.dart';
import 'package:private_lesson_app/models/subject.dart';
import 'package:private_lesson_app/api/leveleducation_api.dart';
import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:private_lesson_app/widget/admin_widget/subLvl_widget.dart';
import 'package:private_lesson_app/widget/slidable_widget.dart';
import 'package:private_lesson_app/pages/main_search.dart';

class SubjectAdminWidget extends StatefulWidget {
  SubjectAdminWidget({Key? key}) : super(key: key);

  @override
  _SubjectAdminWidgetState createState() => _SubjectAdminWidgetState();
}

class _SubjectAdminWidgetState extends State<SubjectAdminWidget> {
  late TextEditingController searchController;
  late TextEditingController subjectNameController;
  late TextEditingController subjectPicController;
  late List<Subject> _subjectList = [];
  late List<Leveleducation> _leveleducationList = [];
  late int _leveleducationSelectedValue = 1;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    subjectNameController = TextEditingController();
    subjectPicController = TextEditingController();
    isLoading = true;
    LeveleducationAPI.getLeveleducations().then((value) {
      setState(() {
        _leveleducationList = value;
        if (_leveleducationList.length > 0)
          _leveleducationSelectedValue = _leveleducationList[0].id;
      });
    });
    SubjectAPI.getSubjects().then((value) {
      setState(() {
        _subjectList = value;
      });
    }).whenComplete(() => isLoading = false);
  }

  //*****************************************Add subject */

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
                                      //------------name--------------------------
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
                                      child: TextFormField(
                                        controller: subjectNameController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Input Subject name',
                                          prefixIcon: Icon(
                                            Icons.text_fields,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      //------------subject pic--------------------------
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
                                      child: TextFormField(
                                        controller: subjectPicController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Input Subject pic',
                                          prefixIcon: Icon(
                                            Icons.image,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        //------------Level education--------------------------
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            constLeft,
                                            constTop,
                                            constRight,
                                            constBottom),
                                        child: DropdownButtonFormField(
                                          // value: _citySelectedValue,
                                          items: _leveleducationList
                                              .map((itemList) {
                                            print(itemList);
                                            return DropdownMenuItem(
                                              child: Text(itemList.name),
                                              value: itemList.id,
                                            );
                                          }).toList(),
                                          onChanged: (leveleducationId) {
                                            // log(value);
                                            print(leveleducationId);
                                            setState(() {
                                              _leveleducationSelectedValue =
                                                  leveleducationId as int;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.list),
                                            border: const OutlineInputBorder(),
                                          ),
                                        )),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          SubjectAPI.addSubjects(new Subject(
                                                  name: subjectNameController
                                                      .text,
                                                  leveleducation:
                                                      _leveleducationSelectedValue,
                                                  pic: subjectPicController
                                                      .text))
                                              .then((value) {
                                            if (value) {
                                              showSnackBar(context,
                                                  'added successfully');
                                            } else {
                                              showSnackBar(
                                                  context, 'wrong something');
                                            }
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
              itemCount: _subjectList.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final item = _subjectList[index];

                return SlidableWidget(
                  child: buildListTileSubject(item),
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
          .edit: //*************************** update Subject ***** */
        subjectNameController.text = _subjectList[index].name;
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
                              controller: subjectNameController,
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
                                _subjectList[index].name =
                                    subjectNameController.text;
                                SubjectAPI.updateASubject(_subjectList[index]);
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
        break;
      case SlidableAction
          .delete: //*************************** delete Subject ***** */
        var tempSubject = _subjectList.elementAt(index);
        SubjectAPI.deleteSubject(tempSubject.id.toString()).then((value) {
          if (value) {
            setState(() {
              _subjectList.removeAt(index);
            });
            showSnackBar(context, 'Deleted the subject ${tempSubject.name}');
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

  //************************************************Build List subject
  Widget buildListTileSubject(Subject item) => ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        title: ItemAdminWidget(itemsList: item),
        onTap: () {},
      );
}
