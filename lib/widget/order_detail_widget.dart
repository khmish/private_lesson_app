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
  // TextEditingController studentname = TextEditingController();
  // TextEditingController teachername = TextEditingController();
  // TextEditingController subject = TextEditingController();
  // TextEditingController state = TextEditingController();
  // TextEditingController price = TextEditingController();
  TextEditingController rating = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // studentname.text = widget.lesson.student!.name ?? "";
    // teachername.text = widget.lesson.teacher!.name ?? "";
    // subject.text = widget.lesson.subject!.name;
    // state.text = widget.lesson.state!.toString();
    // price.text = widget.lesson.price!.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: TextStyle(color: colorMainText),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
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
                        height: 30,
                      ),

                      //------------order number--------------------------
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.format_list_numbered,
                                size: 23,
                                color: Colors.black87,
                              ),
                              Text(
                                ' Order no.:',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black87,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 2.0, color: Colors.black12),
                          ),
                        ),
                        child: Text(
                          '     #${widget.lesson.id}\n',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: colorInputTextBox,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      //------------student name--------------------------
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.person_outline,
                                size: 23,
                                color: Colors.black87,
                              ),
                              Text(
                                ' Student name:',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black87,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 2.0, color: Colors.black12),
                          ),
                        ),
                        child: Text(
                          '     ${widget.lesson.student!.name}\n',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: colorInputTextBox,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      //------------teacher name--------------------------
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.person_outline,
                                size: 23,
                                color: Colors.black87,
                              ),
                              Text(
                                ' Teacher name:',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black87,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 2.0, color: Colors.black12),
                          ),
                        ),
                        child: Text(
                          '     ${widget.lesson.teacher!.name}\n',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: colorInputTextBox,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      //------------subject--------------------------
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.subject,
                                size: 23,
                                color: Colors.black87,
                              ),
                              Text(
                                ' Subject:',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black87,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 2.0, color: Colors.black12),
                          ),
                        ),
                        child: Text(
                          '     ${widget.lesson.subject!.name}\n',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: colorInputTextBox,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      //------------order price--------------------------
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.price_change_outlined,
                                size: 23,
                                color: Colors.black87,
                              ),
                              Text(
                                ' Price in hour:',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black87,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 2.0, color: Colors.black12),
                          ),
                        ),
                        child: Text(
                          '     ${widget.lesson.price!.toString()}\$\n',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: colorInputTextBox,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      //------------order state--------------------------
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.change_circle_outlined,
                                size: 23,
                                color: Colors.black87,
                              ),
                              Text(
                                ' Order state:',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black87,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 2.0, color: Colors.black12),
                          ),
                        ),
                        child: Text(
                          '     ${widget.lesson.state!.toString()}\n',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: colorInputTextBox,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // TextWidget.textWidget('Student Name',
                      //     length: 200,
                      //     textController: studentname,
                      //     icon: Icons.offline_pin_rounded),
                      // TextWidget.textWidget('Teacher Name',
                      //     length: 200,
                      //     textController: teachername,
                      //     icon: Icons.offline_pin_rounded),
                      // TextWidget.textWidget('Subject',
                      //     length: 200,
                      //     textController: subject,
                      //     icon: Icons.offline_pin_rounded),
                      // TextWidget.textWidget('state',
                      //     length: 200,
                      //     textController: state,
                      //     icon: Icons.offline_pin_rounded),
                      // TextWidget.textWidget('price',
                      //     length: 200,
                      //     textController: price,
                      //     icon: Icons.offline_pin_rounded),
                      if (widget.lesson.state!.toLowerCase() == "accepted")
                        ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatWidget(
                                          lesson: widget.lesson,
                                        )),
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
