import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/city.dart';

class DrpCityWidget extends StatefulWidget {
  int selectedValue;
  List<City> listObject;
  String title;
  DrpCityWidget(
      {Key? key,
      required this.title,
      required this.selectedValue,
      required this.listObject})
      : super(key: key);

  @override
  _DrpCityWidgetState createState() => _DrpCityWidgetState();
}

class _DrpCityWidgetState extends State<DrpCityWidget> {
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
          onChanged: (cityId) {
            setState(() {
              widget.selectedValue = cityId as int;
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
