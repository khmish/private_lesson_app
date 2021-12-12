import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';

class RatingInputWidget extends StatefulWidget {
  Function(int) selectedValue;
  int rating = 0;
  RatingInputWidget(
      {Key? key, required this.selectedValue, required this.rating})
      : super(key: key);

  @override
  _RatingInputWidgetState createState() => _RatingInputWidgetState();
}

class _RatingInputWidgetState extends State<RatingInputWidget> {
  onClick(int paraRating) {
    setState(() {
      widget.rating = paraRating;
      widget.selectedValue(paraRating);
    });
    print(widget.rating);
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        // width: 330,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        // decoration: BoxDecoration(
        //   // color: (colorInputTextBox),
        //   borderRadius: BorderRadius.circular(10),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(
            //   "${widget.rating}",
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 30,
            //     // color: Colors.green
            //   ),
            // ),
            Row(
              textBaseline: TextBaseline.alphabetic,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.rating = 1;
                    });
                    widget.selectedValue(1);
                    print(widget.rating);
                  },
                  icon: Icon(
                    Icons.star_rounded,
                    size: 30,
                    
                    color: (widget.rating >= 1) ? Colors.amber.shade900 : Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.rating = 2;
                      widget.selectedValue(2);
                    });
                    print(widget.rating);
                  },
                  icon: Icon(
                    Icons.star_rounded,
                    size: 30,
                    color: widget.rating >= 2 ? Colors.amber.shade900 : Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.rating = 3;
                      widget.selectedValue(3);
                    });
                    print(widget.rating);
                  },
                  icon: Icon(
                    Icons.star_rounded,
                    size: 30,
                    color: widget.rating >= 3 ? Colors.amber.shade900 : Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.rating = 4;
                      widget.selectedValue(4);
                    });
                    print(widget.rating);
                  },
                  icon: Icon(
                    Icons.star_rounded,
                    size: 30,
                    color: widget.rating >= 4 ? Colors.amber.shade900 : Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.rating = 5;
                      widget.selectedValue(5);
                    });
                    print(widget.rating);
                  },
                  icon: Icon(
                    Icons.star_rounded,
                    size: 30,
                    color: widget.rating >= 5 ? Colors.amber.shade900 : Colors.black,
                  ),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
