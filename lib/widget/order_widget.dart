import 'dart:ui';

import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/lesson.dart';
import 'package:private_lesson_app/models/tutor_subs_lvl_ed.dart';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/pages/teacher_details.dart';

import 'package:private_lesson_app/pages/homepage1.dart';

class OrderWidget extends StatefulWidget {
  final List<Lesson> ordersList;
  late User myuser;
  OrderWidget({Key? key, required this.ordersList}) : super(key: key);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  User myuser =
      new User(id: -1, name: '', email: '', city: -1, phone: '', gender: '');

  @override
  void initState() {
    super.initState();
    checksIfLogIn().then((value) {
      setState(() {
        myuser = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 10),
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .6,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 1000
                      ? 3
                      : MediaQuery.of(context).size.width > 600
                          ? 2
                          : 1,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  mainAxisExtent: 150),
              // shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: widget.ordersList.length,
              // padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 23),
                  decoration: BoxDecoration(
                    color: (colorContainerBox),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      //moe to next page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHome()),
                      );

                      /*********************************ORDER ON CLICK ************/
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => DetailScreen(),
                      //       settings: RouteSettings(
                      //           arguments: widget.ordersList[index])),
                      // );
                    },
                    child: Stack(
                      // fit: StackFit.loose,
                      // alignment: Alignment.center,
                      overflow: Overflow.visible,
                      children: [
                        // ********************Student *******************************
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            // decoration: BoxDecoration(
                            //   color: Color(0xFFFF6F25),
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 200,
                              ),
                              child: Chip(
                                avatar: CircleAvatar(
                                  backgroundColor: (colorMainText),
                                  child: Text("St"),
                                ),
                                label: Text(
                                  '${widget.ordersList[index].student!.name}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: (colorMainText),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ********************Teacher *******************************
                        Positioned(
                          top: 40,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 200,
                                ),
                                child: Chip(
                                  avatar: CircleAvatar(
                                    backgroundColor: (colorMainText),
                                    child: Text("Te"),
                                  ),
                                  label: Text(
                                    '${widget.ordersList[index].teacher!.name}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: (colorMainText),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                          ),
                        ),

                        // ********************State *******************************
                        Positioned(
                          top: -15,
                          right: -10,
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "${widget.ordersList[index].state!.toUpperCase()}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: (colorMainText),
                                ),
                              )),
                        ),

                        // ********************Accept/Cancel Buttons *******************************
                        if (widget.ordersList[index].state == "new")
                          if (myuser.role == "tutor")
                            Positioned(
                              top: 80,
                              right: 75,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                // decoration: BoxDecoration(
                                //   color: Colors.blue,
                                //   borderRadius: BorderRadius.circular(3),
                                // ),
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                  ),
                                  onPressed: null,
                                  label: Text(
                                    'Accept',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.8)),
                                  ),
                                  icon: Icon(
                                    Icons.done,
                                    color: Colors.black.withOpacity(0.8),
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                        if (widget.ordersList[index].state == "new")
                          if (myuser.role == "tutor")
                            Positioned(
                              top: 80,
                              right: -20,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                // decoration: BoxDecoration(
                                //   color: Colors.blue,
                                //   borderRadius: BorderRadius.circular(3),
                                // ),
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                  ),
                                  onPressed: null,
                                  label: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.8)),
                                  ),
                                  icon: Icon(
                                    Icons.clear,
                                    color: Colors.black.withOpacity(0.8),
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
