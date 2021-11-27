import 'package:flutter/material.dart';
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
    widget.lesson.student!.name;
    return Container();
  }
}
