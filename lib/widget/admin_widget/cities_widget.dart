import 'dart:ui';

import 'package:private_lesson_app/constants/size_const.dart';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/models/city.dart';

class CitiesAdminWidget extends StatefulWidget {
  final City citiesList;
  CitiesAdminWidget({Key? key, required this.citiesList}) : super(key: key);

  @override
  _CitiesAdminWidgetState createState() => _CitiesAdminWidgetState();
}

class _CitiesAdminWidgetState extends State<CitiesAdminWidget> {
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
                        child: Icon(Icons.location_city_rounded,size: 35,),
                        radius: 35,
                      ),
                    ),
                    SizedBox(height: 2,),
                   
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
                            maxWidth: 300,
                          ),
                          child: Chip(
                            avatar: CircleAvatar(
                              backgroundColor: (colorMainText),
                              child: Text("${widget.citiesList.name.substring(0,2).toUpperCase()}"),
                            ),
                            label: Text(
                              // ***********************City name*****************
                              '${widget.citiesList.name}',
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
                            maxWidth: MediaQuery.of(context).size.width>500?250: 150,
                          ),
                          child: Chip(
                            // backgroundColor: colorContainerBox,
                            avatar: CircleAvatar(
                              backgroundColor: (colorMainText),
                              child: Icon(Icons.place),
                            ),
                            // ***********************Country name*****************
                            label: Text(
                              '${widget.citiesList.countryName}',
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
