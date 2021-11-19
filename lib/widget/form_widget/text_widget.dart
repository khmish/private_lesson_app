import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';

class TextWidget {
  static Widget textWidget(
    String title, {
    required int length,
    required TextEditingController textController,
    required IconData icon,
   int keyboardTp=0,

  }) {
    return Container(
      //------------Email--------------------------
      padding: EdgeInsetsDirectional.fromSTEB(
          constLeft, constTop, constRight, constBottom),
      child: TextFormField(
        //add here
        maxLength: length,
        maxLengthEnforced: true,

        //
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your username';
          }
          return null;
        },

        controller: textController,
        obscureText: false,
        style: TextStyle(
          color: colorInputTextBox,
        ),
        decoration: InputDecoration(
          labelText: title,
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
          prefixIcon: Icon(
            icon,
            color: colorInputTextBox,
          ),
        ),
        keyboardType: keyboardTp==0?TextInputType.text:keyboardTp==1?TextInputType.emailAddress:TextInputType.number,
      ),
    );
  }
}
