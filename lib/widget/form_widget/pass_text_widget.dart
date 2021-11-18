import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';

// ignore: must_be_immutable
class PasswordTextWidget extends StatefulWidget {
  late TextEditingController textController;
  late int length;
  PasswordTextWidget( {
    Key? key,
    required this.length,
    required this.textController,
  }) : super(key: key);

  @override
  _PasswordTextWidgetState createState() => _PasswordTextWidgetState();
}

class _PasswordTextWidgetState extends State<PasswordTextWidget> {
  var passwordVisibility = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      //------------Password--------------------------
      padding: EdgeInsetsDirectional.fromSTEB(
          constLeft, constTop, constRight, constBottom),

      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
        maxLength: widget.length,
        maxLengthEnforced: true,
        controller: widget.textController,
        obscureText: !passwordVisibility,
        style: TextStyle(
          color: colorBox,
        ),
        decoration: InputDecoration(
          labelText: 'Password',
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
          prefixIcon: Icon(
            Icons.lock,
            color: colorBox,
          ),
          suffixIcon: InkWell(
            onTap: () => setState(
              () => passwordVisibility = !passwordVisibility,
            ),
            child: Icon(
              passwordVisibility
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: colorBox,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
