import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/subject.dart';

class DrpSubWidget extends StatefulWidget {
  int selectedValue;
  List<Subject> listObject;
  String title;
  DrpSubWidget(
      {Key? key,
      required this.title,
      required this.selectedValue,
      required this.listObject})
      : super(key: key);

  @override
  _DrpSubWidgetState createState() => _DrpSubWidgetState();
}

class _DrpSubWidgetState extends State<DrpSubWidget> {
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
          onChanged: (subId) {
            setState(() {
              widget.selectedValue = subId as int;
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
            labelStyle: TextStyle(color: colorInputTextBox),
            fillColor: colorInputTextBox,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorInputTextBox,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorInputTextBox,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
