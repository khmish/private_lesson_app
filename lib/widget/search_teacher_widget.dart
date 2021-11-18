import 'dart:ui';

import 'package:private_lesson_app/models/tutor_subs_lvl_ed.dart';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/pages/teacher_details.dart';

class SearchTeacherWidget extends StatefulWidget {
  final List<TutorSubsLvEd> tutorsList;
  SearchTeacherWidget({Key? key, required this.tutorsList}) : super(key: key);

  @override
  _SearchTeacherWidgetState createState() => _SearchTeacherWidgetState();
}

class _SearchTeacherWidgetState extends State<SearchTeacherWidget> {
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
              itemCount: widget.tutorsList.length,
              // padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 23),
                  decoration: BoxDecoration(
                    color: Color(0xFF2F2F2F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(),
                            settings: RouteSettings(
                                arguments: widget.tutorsList[index])),
                      );
                    },
                    child: Stack(
                      // fit: StackFit.loose,
                      // alignment: Alignment.center,
                      overflow: Overflow.visible,
                      children: [
                        // ********************Picture *******************************
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              LayoutBuilder(builder:
                                  (context, BoxConstraints constraints) {
                                double widthCon =
                                    MediaQuery.of(context).size.width*.9;
                                double maxwidthCon =0;
                                if (widthCon >= 1000) {
                                  maxwidthCon = widthCon / 3;
                                } else if (widthCon >= 600) {
                                  maxwidthCon = widthCon / 2;

                                } else {
                                  maxwidthCon = widthCon ;

                                }

                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  
                                  width: maxwidthCon,
                                  height: 60,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(12)),
                                  child: Image.network(
                                    'https://thumbs.dreamstime.com/b/back-to-school-background-copy-space-121767227.jpg',
                                    fit: BoxFit.fitWidth,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),

                        // ********************Name *******************************
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
                                maxWidth: 140,
                              ),
                              child: Text(
                                '${widget.tutorsList[index].name}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFFF6F25),
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),

                        // ********************Stars *******************************
                        Positioned(
                          bottom: -25,
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
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 24,
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  size: 24,
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  size: 24,
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.black,
                                  size: 24,
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.black,
                                  size: 24,
                                )
                              ],
                            ),
                          ),
                        ),
                        // ********************Price *******************************
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            // decoration: BoxDecoration(
                            //   color: Colors.redAccent[100],
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            child: Text(
                              '\$${widget.tutorsList[index].price}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFFFFFFFF),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        // ********************Subjects *******************************
                        Positioned(
                          top: 50,
                          left: 20,
                          child: Container(
                            width: 400,
                            height: 40,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount:
                                  widget.tutorsList[index].subjects.length > 4
                                      ? 4
                                      : widget
                                          .tutorsList[index].subjects.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1, mainAxisExtent: 70),
                              itemBuilder: (context, index1) {
                                return Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 2),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "${widget.tutorsList[index].subjects[index1].subject}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
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
