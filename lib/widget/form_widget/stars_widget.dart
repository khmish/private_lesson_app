import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';

class StarsWidget {
  static Widget starsWidget({
    required double numberOfStars,
  }) {
    double fraction = numberOfStars - numberOfStars.truncate();
    int tempNumberOfStars = int.parse(numberOfStars.floor().toString());
    int tempNumberOfEmptyStars =
        5 - (tempNumberOfStars + (fraction > 0 ? 1 : 0));

    return Positioned(
      bottom: -25,
      right: -10,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("${numberOfStars.toStringAsFixed(1)}"),
              ...[
                for (int i = 0; i < tempNumberOfEmptyStars; i++)
                  Icon(
                    Icons.star_rounded,
                    size: 24,
                  ),
                
                if (fraction > 0)
                  Icon(
                    Icons.star_half_rounded,
                    size: 24,
                  ),
                for (int i = 0; i < tempNumberOfStars; i++)
                  Icon(
                    Icons.star_outline_rounded,
                    size: 24,
                  ),
              ],
            ],
          )),
    );
  }
}
