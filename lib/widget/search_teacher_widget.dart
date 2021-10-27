import 'dart:ui';

import 'package:private_lesson_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/pages/userprofile.dart';

class SearchTeacherWidget extends StatefulWidget {
  final List<User> userList;
  SearchTeacherWidget({Key? key, required this.userList}) : super(key: key);

  @override
  _SearchTeacherWidgetState createState() => _SearchTeacherWidgetState();
}

class _SearchTeacherWidgetState extends State<SearchTeacherWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
      child: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .6,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).size.width > 1000 ? 3 : MediaQuery.of(context).size.width > 600?2:1,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                mainAxisExtent: 165),
            // shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.userList.length,
            // padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 23),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailScreen(),
                          settings:
                              RouteSettings(arguments: widget.userList[index])),
                    );
                  },
                  child: Stack(
                    // fit: StackFit.loose,
                    alignment:Alignment.center ,
                    overflow: Overflow.visible,
                    children: [
                      // ********************Name *******************************
                      Positioned(
                        top: -25,
                        left: 0,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 120,
                            ),
                            child: Text(
                              '${widget.userList[index].name}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold

                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      // ********************Picture *******************************
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: 2,
                                sigmaY: 2,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/305/600',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ********************Stars *******************************
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5) ,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 20,
                              ),
                              Icon(
                                Icons.star_rounded,
                                size: 20,
                              ),
                              Icon(
                                Icons.star_rounded,
                                size: 20,
                              ),
                              Icon(
                                Icons.star_rounded,
                                color: Colors.black,
                                size: 20,
                              ),
                              Icon(
                                Icons.star_rounded,
                                color: Colors.black,
                                size: 20,
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
                          margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5) ,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                           decoration: BoxDecoration(
                            color: Colors.redAccent[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '100\$ / hour',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    Positioned(
                        left: 120,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                              margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5) ,
                              padding:
                                  EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                               decoration: BoxDecoration(
                                color: Colors.blueAccent[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Maths',
                              ),
                            ),
                          
                            Container(
                              margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5) ,
                              padding:
                                  EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                               decoration: BoxDecoration(
                                color: Colors.blueAccent[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Physics',
                              ),
                            ),
                          
                            Container(
                              margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5) ,
                              padding:
                                  EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                               decoration: BoxDecoration(
                                color: Colors.blueAccent[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Others',
                              ),
                            ),
                          
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5) ,
                                  padding:
                                      EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                   decoration: BoxDecoration(
                                    color: Colors.blueAccent[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Maths',
                                  ),
                                ),
                              
                                Container(
                                  margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5) ,
                                  padding:
                                      EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                   decoration: BoxDecoration(
                                    color: Colors.blueAccent[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Physics',
                                  ),
                                ),
                              
                                Container(
                                  margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5) ,
                                  padding:
                                      EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                   decoration: BoxDecoration(
                                    color: Colors.blueAccent[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Others',
                                  ),
                                ),
                              
                                
                              ],
                            ),
                          ],
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
    );
  }
}
