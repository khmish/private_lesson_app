import 'dart:ui';

import 'package:private_lesson_app/constants/size_const.dart';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/pages/teacher_details.dart';

class UsersAdminWidget extends StatefulWidget {
  final User usersList;
  UsersAdminWidget({Key? key, required this.usersList}) : super(key: key);

  @override
  _UsersAdminWidgetState createState() => _UsersAdminWidgetState();
}

class _UsersAdminWidgetState extends State<UsersAdminWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
            // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 23),
            decoration: BoxDecoration(
              color: (colorContainerBox),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(
                               horizontal: 7),
                          margin: EdgeInsets.symmetric(
                               horizontal: 7),
                      child: CircleAvatar(
                        backgroundColor: colorPrimaryBTN,
                        child: Icon(Icons.person,size: 35,),
                        radius: 35,
                      ),
                    ),
                    SizedBox(height: 2,),
                    // ********************State *******************************
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 7),
                        padding: EdgeInsets.symmetric(
                             horizontal: 7),
                        
                        child: Text(
                          "${widget.usersList.role!.toUpperCase()}",
                          style: TextStyle(
                            fontSize: 15,
                            color: (colorMainText),
                            fontWeight: FontWeight.bold
                          ),
                        )),
                    SizedBox(height: 10,),

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      margin: EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 150,
                          ),
                          child: Chip(
                            avatar: CircleAvatar(
                              backgroundColor: (colorMainText),
                              child: Text("${widget.usersList.role!.substring(0,2).toUpperCase()}"),
                            ),
                            label: Text(
                              '${widget.usersList.name}',
                              style: TextStyle(
                                fontSize: 20,
                                color: (colorMainText),
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                    ),
                    Container(
                      
                      padding: EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      margin: EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 150,
                          ),
                          child: Chip(
                            backgroundColor: colorContainerBox,
                            avatar: CircleAvatar(
                              backgroundColor: (colorMainText),
                              child: Icon(Icons.alternate_email),
                            ),
                            label: Text(
                              '${widget.usersList.email}',
                              style: TextStyle(
                                fontSize: 20,
                                color: (colorMainText),
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                    ),
    
                    
                  
                  ],
                ),
              ],
            ),
         
    );
      
  }
}
