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
          height: MediaQuery.of(context).size.height*.6 ,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 1000 ? 3 : 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 2,
                mainAxisExtent: 150),
            // shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.userList.length,
            // padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return  Container(
                
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(),
                                settings: RouteSettings(
                                    arguments: widget.userList[index])),
                          );
                        
                      },
                      child: Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRect(
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(
                                  sigmaX: 2,
                                  sigmaY: 2,
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      'https://picsum.photos/seed/305/600',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: 100,
                                      ),
                                      child: Text(
                                        '${widget.userList[index].name}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'id:  ${widget.userList[index].id}',
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                                    child: Text(
                                      '100\$ /hour',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
