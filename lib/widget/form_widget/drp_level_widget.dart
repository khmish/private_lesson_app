import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/leveleducation.dart';

class DrpLevelWidget extends StatefulWidget {
  int selectedValue;
  List<Leveleducation> listObject;
  String title;
  DrpLevelWidget(
      {Key? key,
      required this.title,
      required this.selectedValue,
      required this.listObject})
      : super(key: key);

  @override
  _DrpLevelWidgetState createState() => _DrpLevelWidgetState();
}

class _DrpLevelWidgetState extends State<DrpLevelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //------------Gender--------------------------
      padding: EdgeInsetsDirectional.fromSTEB(
          constLeft, constTop, constRight, constBottom),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: DropdownButtonFormField(
          value: widget.selectedValue,
          onChanged: (levelId) {
            setState(() {
              widget.selectedValue = levelId as int;
            });
          },
          items: widget.listObject.map((itemList) {
            return DropdownMenuItem(
              child: Text(itemList.name),
              value: itemList.id,
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: widget.title,
            labelStyle: TextStyle(color: colorBox),
            fillColor: colorBox,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorBox,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorBox,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
