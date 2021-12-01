import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/lesson.dart';

import 'form_widget/rating_widget.dart';

class OrderDetail extends StatefulWidget {
  late Lesson lesson;
  OrderDetail({Key? key, required this.lesson}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  String studentname = "";
  String teachername = "";
  String subject = "";
  String state = "";
  String price = "";
  int rating = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentname = widget.lesson.student!.name ?? "";
    teachername = widget.lesson.teacher!.name ?? "";
    subject = widget.lesson.subject!.name;
    state = widget.lesson.state!;
    price = widget.lesson.price!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        backgroundColor: (colorContainerBox),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
            elevation: 4.0,
            child: Column(
              children: [
                ListTile(
                  title: Text("Details"),
                  // subtitle: Text("Detailssss"),
                  // trailing: Icon(Icons.favorite_outline),
                ),
                Container(
                  child: Column(
                    children: [
                      Text("Student Name: " + studentname),
                      Text("Teacher Name: " + teachername),
                      Text("Subject: " + subject),
                      Text("State: " + state),
                      Text("Price: " + price),
                    ],
                  ),
                ),
                Container(
                  child: RatingInputWidget(
                    rating: rating,
                    selectedValue: (rate) {
                      setState(() {
                        rating = rate;
                      });
                    },
                  ),
                ),
                ButtonBar(
                  children: [
                    // TextButton(
                    //   child: const Text('Change'),
                    //   onPressed: () {/* ... */},
                    // ),
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        /* ... */
                      },
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
