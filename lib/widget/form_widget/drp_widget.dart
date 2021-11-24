import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';

class DrpWidget extends StatefulWidget {
  var defalutValue;
  Function(String) selectedValue;
  List listObject;
  String title;
  DrpWidget(
      {Key? key,
      required this.title,
      required this.selectedValue,
      required this.listObject,
      this.defalutValue
      })
      : super(key: key);

  @override
  _DrpWidgetState createState() => _DrpWidgetState();
}

class _DrpWidgetState extends State<DrpWidget> {
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
          value: widget.defalutValue,
          onChanged: (newValue) {
            setState(() {
              widget.selectedValue(newValue.toString());
            });
          },
          items: widget.listObject.map((dynamic itemList) {
            return DropdownMenuItem(
              child: Text(itemList),
              value: itemList,
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
