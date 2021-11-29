import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/lesson.dart';

class OrderDetail extends StatefulWidget {
  late Lesson lesson;
  OrderDetail({Key? key, required this.lesson}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    var studentname = widget.lesson.student!.name;
    var teachername = widget.lesson.teacher!.name;
    var subject = widget.lesson.subject!.name;
    var state = widget.lesson.state!;


    return Scaffold(
      appBar: AppBar(
          title:Text("Order Details"),
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
                      Text("Student Name: " + studentname!),
                      Text("Teacher Name: " + teachername!),
                      Text("Subject: " + subject!),
                      Text("State: " + state!),

                    ],
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
