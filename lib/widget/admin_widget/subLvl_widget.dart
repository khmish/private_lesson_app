import 'dart:ui';

import 'package:private_lesson_app/constants/size_const.dart';
import 'package:flutter/material.dart';

class ItemAdminWidget extends StatefulWidget {
  final dynamic itemsList;
  ItemAdminWidget({Key? key, required this.itemsList}) : super(key: key);

  @override
  _ItemAdminWidgetState createState() => _ItemAdminWidgetState();
}

class _ItemAdminWidgetState extends State<ItemAdminWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 23),
      decoration: BoxDecoration(
        color: (colorContainerBox),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                margin: EdgeInsets.symmetric(horizontal: 7),
                child: CircleAvatar(
                  backgroundColor: colorPrimaryBTN,
                  child: Icon(
                    Icons.book_rounded,
                    size: 35,
                  ),
                  radius: 35,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Text(
              '${widget.itemsList.name}',
              style: TextStyle(
                fontSize: 20,
                color: (colorSeText),
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
