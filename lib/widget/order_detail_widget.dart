import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/lesson.dart';
import 'package:private_lesson_app/widget/chat/chat_widget.dart';
import 'package:private_lesson_app/widget/form_widget/text_widget.dart';

import 'form_widget/rating_widget.dart';

class OrderDetail extends StatefulWidget {
  late Lesson lesson;
  OrderDetail({Key? key, required this.lesson}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  TextEditingController studentname = TextEditingController();
  TextEditingController teachername = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController rating = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentname.text = widget.lesson.student!.name ?? "";
    teachername.text = widget.lesson.teacher!.name ?? "";
    subject.text = widget.lesson.subject!.name;
    state.text = widget.lesson.state!.toString();
    price.text = widget.lesson.price!.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: TextStyle(color: colorMainText),
        ),
        backgroundColor: (colorContainerBox),
      ),
      backgroundColor: colorBackGround,
      body: SingleChildScrollView(
        child: Center(
          //child: Column(
          child: Form(
            // del here if som wrong
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width*.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    shape: BoxShape.rectangle,
                    color: (colorContainerBox),

                    // border: Border.all(
                    //   width: 1,
                    // ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      TextWidget.textWidget('Student Name',
                          length: 200,
                          textController: studentname,
                          icon: Icons.offline_pin_rounded),
                      TextWidget.textWidget('Teacher Name',
                          length: 200,
                          textController: teachername,
                          icon: Icons.offline_pin_rounded),
                      TextWidget.textWidget('Subject',
                          length: 200,
                          textController: subject,
                          icon: Icons.offline_pin_rounded),
                      TextWidget.textWidget('state',
                          length: 200,
                          textController: state,
                          icon: Icons.offline_pin_rounded),
                      TextWidget.textWidget('price',
                          length: 200,
                          textController: price,
                          icon: Icons.offline_pin_rounded),
                      if (state.text.toLowerCase() == "accepted")
                        ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatWidget(lesson: widget.lesson,)),
                              );
                            },
                            icon: Icon(Icons.chat),
                            label: Text("start chatting"))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
