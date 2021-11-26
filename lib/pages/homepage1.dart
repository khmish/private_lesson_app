import 'package:flutter/material.dart';
import 'package:private_lesson_app/widget/form_widget/rating_widget.dart';

class MyHomeTest extends StatefulWidget {
  MyHomeTest({Key? key}) : super(key: key);

  @override
  _MyHomeTestState createState() => _MyHomeTestState();
}

class _MyHomeTestState extends State<MyHomeTest> {
  int rating = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          
          child: RatingInputWidget(rating: rating,selectedValue: (val) {
              setState(() {
                
              rating = val;
              });
          }),
        ),
      ),
    );
  }
}
