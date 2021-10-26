


//
//
//
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:private_lesson_app/api/city_api.dart';
// import 'package:private_lesson_app/api/leveleducation_api.dart';
// import 'package:private_lesson_app/api/subject_api.dart';
// import 'package:private_lesson_app/api/user_api.dart';
// import 'package:private_lesson_app/models/city.dart';
// import 'package:private_lesson_app/models/leveleducation.dart';
// import 'package:private_lesson_app/models/subject.dart';
// import 'package:private_lesson_app/models/user.dart';
//
// class userPageWidget extends StatefulWidget {
//   const userPageWidget({Key? key}) : super(key: key);
//
//   @override
//   _userPageWidgetState createState() => _userPageWidgetState();
// }
//
// class _userPageWidgetState extends State<userPageWidget> {
//
//   bool _checkbox = false;
//
//   late String dropDownValue1;
//   late List<String> _genderList = ['male', 'female'];
//   String _genderSelectedValue = "male";
//   late List<City> _cityList = [];
//   late int _citySelectedValue = 1;
//   late List<Subject> _subjectList = [];
//   late int _subjectSelectedValue = 1;
//   late List<Leveleducation> _leveleducationList = [];
//   late int _leveleducationSelectedValue = 1;
//   late List<User> _userList = [];
//   late TextEditingController textController;
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//     textController = TextEditingController();
//     CityAPI.getCities().then((value) {
//       setState(() {
//         _cityList = value;
//         if (_cityList.length > 0) _citySelectedValue = _cityList[0].id;
//       });
//     });
//     SubjectAPI.getSubjects().then((value) {
//       setState(() {
//         _subjectList = value;
//         if (_subjectList.length > 0) _subjectSelectedValue = _subjectList[0].id;
//       });
//     });
//     LeveleducationAPI.getLeveleducations().then((value) {
//       setState(() {
//         _leveleducationList = value;
//         if (_leveleducationList.length > 0) _leveleducationSelectedValue = _leveleducationList[0].id;
//       });
//     });
//     UserAPI.getUsers().then((value) {
//       setState(() {
//         _userList = value;
//       });
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         title: Text(
//           'Private Lesson',
//         ),
//         actions: [],
//         centerTitle: true,
//         elevation: 4,
//       ),
//       body: SafeArea(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height * 1,
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
//                 child: TextFormField(
//                   controller: textController,
//                   obscureText: false,
//                   decoration: InputDecoration(
//                     border: const OutlineInputBorder(),
//                     prefixIcon: Icon(
//                       Icons.search,
//                     ),
//                   ),
//                 ),
//               ),
//
//
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
//                   child: GridView(
//                     padding: EdgeInsets.zero,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 4,
//                       crossAxisSpacing: 10,
//                     ),
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     children: [
//                       //
//                       // DropdownButtonFormField(
//                       //   value: _genderSelectedValue,
//                       //   items: _genderList.map((String itemList) {
//                       //     return DropdownMenuItem(
//                       //       child: Text(itemList),
//                       //       value: itemList,
//                       //     );
//                       //   }).toList(),
//                       //   onChanged: (newValue) {
//                       //     setState(() => _genderSelectedValue = newValue.toString());
//                       //   },
//                       //   decoration: const InputDecoration(
//                       //     border: const OutlineInputBorder(),
//                       //   ),
//                       // ),
//                       // DropdownButtonFormField(
//                       //   value: _citySelectedValue,
//                       //   items: _cityList.map((itemList) {
//                       //     print(itemList);
//                       //     return DropdownMenuItem(
//                       //       child: Text(itemList.name),
//                       //       value: itemList.id,
//                       //     );
//                       //   }).toList(),
//                       //   onChanged: (value) {
//                       //     setState(() => _citySelectedValue = value as int);
//                       //   },
//                       //   decoration: const InputDecoration(
//                       //     border: const OutlineInputBorder(),
//                       //   ),
//                       // ),
//                       // DropdownButtonFormField(
//                       //   value: _subjectSelectedValue,
//                       //   items: _subjectList.map((itemList) {
//                       //     print(itemList);
//                       //     return DropdownMenuItem(
//                       //       child: Text(itemList.name),
//                       //       value: itemList.id,
//                       //     );
//                       //   }).toList(),
//                       //   onChanged: (value) {
//                       //     setState(() => _subjectSelectedValue = value as int);
//                       //   },
//                       //   decoration: const InputDecoration(
//                       //     border: const OutlineInputBorder(),
//                       //   ),
//                       // ),
//                       // DropdownButtonFormField(
//                       //   value: _leveleducationSelectedValue,
//                       //   items: _leveleducationList.map((itemList) {
//                       //     print(itemList);
//                       //     return DropdownMenuItem(
//                       //       child: Text(itemList.name),
//                       //       value: itemList.id,
//                       //     );
//                       //   }).toList(),
//                       //   onChanged: (value) {
//                       //     setState(() => _leveleducationSelectedValue = value as int);
//                       //   },
//                       //   decoration: const InputDecoration(
//                       //     border: const OutlineInputBorder(),
//                       //   ),
//                       // ),
//
//
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 // padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
//                 padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height * 0.6,
//                   child: GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       //3:1 -> 1:1
//                         crossAxisCount: MediaQuery.of(context).size.width>1000?1:1,
//                         mainAxisSpacing: 0,
//                         crossAxisSpacing: 2,
//                         mainAxisExtent: 100
//                     ),
//                     // shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     itemCount: _userList.length,
//                     // padding: EdgeInsets.zero,
//                     itemBuilder: (context, index) {
//                       // 1 ----
//                       //
//
//                       return new Column(
//                         //return ListTile(
//                         // 2---- children: [
//
//                         children: [
//
//                           Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsetsDirectional.fromSTEB(
//                                     12, 0, 12, 0),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   children: [
//                                     Card(
//                                       clipBehavior:
//                                       Clip.antiAliasWithSaveLayer,
//                                       // color: FlutterFlowTheme.primaryColor,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                         BorderRadius.circular(50),
//                                       ),
//                                       child: Padding(
//                                         padding:
//                                         EdgeInsetsDirectional.fromSTEB(
//                                             2, 2, 2, 2),
//                                         child: Container(
//                                           width: 50,
//                                           height: 50,
//                                           clipBehavior: Clip.antiAlias,
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                           ),
//
//                                           //
//                                           // child: CachedNetworkImage(
//                                           //   imageUrl:
//                                           //   valueOrDefault<String>(
//                                           //     columnUsersRecord.photoUrl,
//                                           //     'https://image.flaticon.com/icons/png/512/3135/3135715.png',
//                                           //   ),
//                                           // ),
//
//
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   children: [
//                                     Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         Text(
//
//                                           columnUsersRecord.displayName,
//
//                                           //
//                                           // style: FlutterFlowTheme.subtitle1
//                                           //     .override(
//                                           //   fontFamily: 'Lexend Deca',
//                                           //   color: FlutterFlowTheme
//                                           //       .tertiaryColor,
//                                         ),
//
//                                         // ),
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         Expanded(
//                                           child: Padding(
//                                             padding: EdgeInsetsDirectional
//                                                 .fromSTEB(0, 4, 4, 0),
//                                             child: Text(
//                                               columnUsersRecord.email,
//                                               //
//                                               // style: FlutterFlowTheme
//                                               //     .bodyText2
//                                               //     .override(
//                                               //   fontFamily: 'Lexend Deca',
//                                               //   // color: FlutterFlowTheme
//                                               //   //     .primaryColor,
//                                               //   fontSize: 12,
//                                               //   fontWeight: FontWeight.w500,
//                                               // ),
//
//
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     Expanded(
//                                       child: Align(
//                                         alignment:
//                                         AlignmentDirectional(0, 0),
//                                         child: ClipRRect(
//                                           borderRadius:
//                                           BorderRadius.circular(5),
//                                           child: SwitchListTile(
//                                             value: switchListTileValue1 ??=
//                                             true,
//                                             onChanged: (newValue) =>
//                                                 setState(() =>
//                                                 switchListTileValue1 =
//                                                     newValue),
//                                             title: Text(
//                                               'Title',
//
//                                               //
//                                               // style: FlutterFlowTheme.title3
//                                               //     .override(
//                                               //   fontFamily: 'Lexend Deca',
//                                               //   fontSize: 16,
//                                               // ),
//
//
//                                             ),
//                                             subtitle: Text(
//                                               'Subtitle',
//
//                                               //
//                                               // style: FlutterFlowTheme
//                                               //     .bodyText2
//                                               //     .override(
//                                               //   fontFamily: 'Lexend Deca',
//                                               // ),
//                                             ),
//                                             tileColor: Color(0xFFF5F5F5),
//                                             dense: false,
//                                             controlAffinity:
//                                             ListTileControlAffinity
//                                                 .trailing,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Align(
//                                         alignment:
//                                         AlignmentDirectional(0, 0),
//                                         child: ClipRRect(
//                                           borderRadius:
//                                           BorderRadius.circular(5),
//                                           child: SwitchListTile(
//                                             value: switchListTileValue2 ??=
//                                             true,
//                                             onChanged: (newValue) =>
//                                                 setState(() =>
//                                                 switchListTileValue2 =
//                                                     newValue),
//                                             title: Text(
//                                               'Title',
//                                               //
//                                               // style: FlutterFlowTheme.title3
//                                               //     .override(
//                                               //   fontFamily: 'Lexend Deca',
//                                               //   fontSize: 16,
//                                               // ),
//
//
//                                             ),
//                                             subtitle: Text(
//
//                                               'Subtitle',
//
//                                               //
//                                               // style: FlutterFlowTheme
//                                               //     .bodyText2
//                                               //     .override(
//                                               //   fontFamily: 'Lexend Deca',
//                                               // ),
//
//                                             ),
//                                             tileColor: Color(0xFFF5F5F5),
//                                             dense: false,
//                                             controlAffinity:
//                                             ListTileControlAffinity
//                                                 .trailing,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Align(
//                                         alignment:
//                                         AlignmentDirectional(0, 0),
//                                         child: ClipRRect(
//                                           borderRadius:
//                                           BorderRadius.circular(5),
//                                           child: SwitchListTile(
//                                             value: switchListTileValue3 ??=
//                                             true,
//                                             onChanged: (newValue) =>
//                                                 setState(() =>
//                                                 switchListTileValue3 =
//                                                     newValue),
//                                             title: Text(
//                                               'Title',
//                                               //
//                                               // style: FlutterFlowTheme.title3
//                                               //     .override(
//                                               //   fontFamily: 'Lexend Deca',
//                                               //   fontSize: 16,
//                                               // ),
//
//
//                                             ),
//                                             subtitle: Text(
//                                               'Subtitle',
//                                               //
//                                               // style: FlutterFlowTheme
//                                               //     .bodyText2
//                                               //     .override(
//                                               //   fontFamily: 'Lexend Deca',
//                                               // ),
//
//                                             ),
//                                             tileColor: Color(0xFFF5F5F5),
//                                             dense: false,
//                                             controlAffinity:
//                                             ListTileControlAffinity
//                                                 .trailing,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsetsDirectional.fromSTEB(
//                                     0, 0, 8, 0),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.chevron_right_rounded,
//                                       color: Color(0xFF82878C),
//                                       size: 24,
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//
//                           // here
//                           // Row(
//                           //   mainAxisSize: MainAxisSize.max,
//                           //   children: [
//                           //     ClipRect(
//                           //       child: ImageFiltered(
//                           //         imageFilter: ImageFilter.blur(
//                           //           sigmaX: 2,
//                           //           sigmaY: 2,
//                           //         ),
//                           //         child: Padding(
//                           //           padding: EdgeInsetsDirectional.fromSTEB(
//                           //               5, 5, 5, 5),
//                           //           child: Container(
//                           //             width: 80,
//                           //             height: 80,
//                           //             clipBehavior: Clip.antiAlias,
//                           //             decoration: BoxDecoration(
//                           //               shape: BoxShape.circle,
//                           //             ),
//                           //             child: Image.network(
//                           //               'https://picsum.photos/seed/305/600',
//                           //             ),
//                           //           ),
//                           //         ),
//                           //       ),
//                           //     ),
//                           //
//                           //
//                           //     Padding(
//                           //       padding:
//                           //       EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
//                           //       child: Column(
//                           //         mainAxisSize: MainAxisSize.max,
//                           //         children: [
//                           //           Padding(
//                           //             padding: EdgeInsetsDirectional.fromSTEB(
//                           //                 0, 0, 0, 15),
//                           //             child: Text(
//                           //                 '${_userList[index].name}'
//                           //             ),
//                           //           ),
//                           //           Text(
//                           //             'id:  ${_userList[index].id}',
//                           //           )
//                           //         ],
//                           //       ),
//                           //     ),
//
//
//
//
//                               //permissions
//
//                               Padding(
//                                 padding:
//                                 EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//
//                                     Row(
//                                       children: [
//                                         Checkbox(
//                                           value: _checkbox,
//                                           onChanged: (value) {
//                                             setState(() {
//                                               _checkbox = true;
//                                             });
//                                           },
//                                         ),
//                                         Text('Admin'),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Checkbox(
//                                           value: _checkbox,
//                                           onChanged: (value) {
//                                             setState(() {
//                                               _checkbox = true;
//                                             });
//                                           },
//                                         ),
//                                         Text('Teacher'),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Checkbox(
//                                           value: _checkbox,
//                                           onChanged: (value) {
//                                             setState(() {
//                                               _checkbox = true;
//                                             });
//                                           },
//                                         ),
//                                         Text('Student'),
//                                       ],
//                                     ),
//
//
//
//
//                                     // $$$
//                                     // Padding(
//                                     //   padding: EdgeInsetsDirectional.fromSTEB(
//                                     //       0, 0, 0, 15),
//                                     //   child: Text(
//                                     //     '100\$ /hour',
//                                     //   ),
//                                     // ),
//
//
//                                     //permissions
//                                     // Row(
//                                     //   mainAxisSize: MainAxisSize.max,
//                                     //   children: [
//                                     //     Icon(
//                                     //       Icons.star_rounded,
//                                     //       size: 20,
//                                     //     ),
//                                     //     Icon(
//                                     //       Icons.star_rounded,
//                                     //       size: 20,
//                                     //     ),
//                                     //     Icon(
//                                     //       Icons.star_rounded,
//                                     //       size: 20,
//                                     //     ),
//                                     //     Icon(
//                                     //       Icons.star_rounded,
//                                     //       color: Colors.black,
//                                     //       size: 20,
//                                     //     ),
//                                     //     Icon(
//                                     //       Icons.star_rounded,
//                                     //       color: Colors.black,
//                                     //       size: 20,
//                                     //     )
//                                     //   ],
//                                     // ),
//
//
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // Divider(thickness: 3, height: 10,)
//
//
//                         ],
//
//
//                       );
//
//                     },
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
// //
// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:flutter/material.dart';
// //
// //
// // class MyFriendsWidget extends StatefulWidget {
// //   MyFriendsWidget({Key? key}) : super(key: key);
// //
// //   @override
// //   _MyFriendsWidgetState createState() => _MyFriendsWidgetState();
// // }
// //
// // class _MyFriendsWidgetState extends State<MyFriendsWidget> {
// //
// //   late bool switchListTileValue1;
// //   late bool switchListTileValue2;
// //   late bool switchListTileValue3;
// //
// //
// //   final scaffoldKey = GlobalKey<ScaffoldState>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       key: scaffoldKey,
// //       appBar: AppBar(
// //         //backgroundColor: FlutterFlowTheme.primaryColor,
// //         automaticallyImplyLeading: false,
// //         title: Text(
// //           'My Team',
// //           //
// //           // style: FlutterFlowTheme.title1.override(
// //           //   fontFamily: 'Lexend Deca',
// //           // ),
// //
// //         ),
// //         actions: [
// //           Padding(
// //             padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
// //             //
// //             // child: FlutterFlowIconButton(
// //             //   borderColor: Colors.transparent,
// //             //   borderRadius: 30,
// //             //   buttonSize: 48,
// //             //   icon: Icon(
// //             //     Icons.close_rounded,
// //             //     color: FlutterFlowTheme.tertiaryColor,
// //             //     size: 30,
// //             //   ),
// //             //   onPressed: () async {
// //             //     Navigator.pop(context);
// //             //   },
// //             // ),
// //
// //           )
// //         ],
// //         centerTitle: false,
// //         elevation: 2,
// //       ),
// //
// //       //backgroundColor: FlutterFlowTheme.background,
// //
// //       body: StreamBuilder<List<>>(
// //
// //         stream: queryUsersRecord(
// //           queryBuilder: (usersRecord) => usersRecord.orderBy('display_name'),
// //         ),
// //
// //
// //         builder: (context, snapshot) {
// //           // Customize what your widget looks like when it's loading.
// //           if (!snapshot.hasData) {
// //             return Center(
// //               child: SizedBox(
// //                 width: 50,
// //                 height: 50,
// //                 child: CircularProgressIndicator(
// //                   //color: FlutterFlowTheme.primaryColor,
// //                 ),
// //               ),
// //             );
// //           }
// //           List<UsersRecord> columnUsersRecordList = snapshot.data;
// //           if (columnUsersRecordList.isEmpty) {
// //             return Center(
// //               child: Image.asset(
// //                 'assets/images/noFriends@2x.png',
// //                 width: MediaQuery.of(context).size.width * 0.9,
// //               ),
// //             );
// //           }
// //           return Column(
// //             mainAxisSize: MainAxisSize.max,
// //             children:
// //             List.generate(columnUsersRecordList.length, (columnIndex) {
// //               final columnUsersRecord = columnUsersRecordList[columnIndex];
// //               return Padding(
// //                 padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
// //                 child: Row(
// //                   mainAxisSize: MainAxisSize.max,
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Padding(
// //                       padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
// //                       child: Material(
// //                         color: Colors.transparent,
// //                         elevation: 2,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                         child: Container(
// //                           width: MediaQuery.of(context).size.width * 0.96,
// //                           height: 150,
// //                           decoration: BoxDecoration(
// //                             // color: FlutterFlowTheme.dark900,
// //                             boxShadow: [
// //                               BoxShadow(
// //                                 // color: FlutterFlowTheme.dark900,
// //                                 offset: Offset(0, 1),
// //                               )
// //                             ],
// //                             borderRadius: BorderRadius.circular(8),
// //                             border: Border.all(
// //                               color: Colors.transparent,
// //                               width: 0,
// //                             ),
// //                           ),
// //                           child: Align(
// //                             alignment: AlignmentDirectional(0, 0),
// //                             child: InkWell(
// //                               // onTap: () async {
// //                               //   await Navigator.push(
// //                               //     context,
// //                               //     MaterialPageRoute(
// //                               //       builder: (context) => ChatDetailsWidget(
// //                               //         chatUser: columnUsersRecord,
// //                               //       ),
// //                               //     ),
// //                               //   );
// //                               // },
// //
// //
// //                               child: Row(
// //                                 mainAxisSize: MainAxisSize.max,
// //                                 mainAxisAlignment: MainAxisAlignment.start,
// //                                 crossAxisAlignment: CrossAxisAlignment.center,
// //                                 children: [
// //                                   Padding(
// //                                     padding: EdgeInsetsDirectional.fromSTEB(
// //                                         12, 0, 12, 0),
// //                                     child: Column(
// //                                       mainAxisSize: MainAxisSize.max,
// //                                       mainAxisAlignment:
// //                                       MainAxisAlignment.center,
// //                                       children: [
// //                                         Card(
// //                                           clipBehavior:
// //                                           Clip.antiAliasWithSaveLayer,
// //                                           // color: FlutterFlowTheme.primaryColor,
// //                                           shape: RoundedRectangleBorder(
// //                                             borderRadius:
// //                                             BorderRadius.circular(50),
// //                                           ),
// //                                           child: Padding(
// //                                             padding:
// //                                             EdgeInsetsDirectional.fromSTEB(
// //                                                 2, 2, 2, 2),
// //                                             child: Container(
// //                                               width: 50,
// //                                               height: 50,
// //                                               clipBehavior: Clip.antiAlias,
// //                                               decoration: BoxDecoration(
// //                                                 shape: BoxShape.circle,
// //                                               ),
// //
// //                                               //
// //                                               // child: CachedNetworkImage(
// //                                               //   imageUrl:
// //                                               //   valueOrDefault<String>(
// //                                               //     columnUsersRecord.photoUrl,
// //                                               //     'https://image.flaticon.com/icons/png/512/3135/3135715.png',
// //                                               //   ),
// //                                               // ),
// //
// //
// //                                             ),
// //                                           ),
// //                                         )
// //                                       ],
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Column(
// //                                       mainAxisSize: MainAxisSize.max,
// //                                       mainAxisAlignment:
// //                                       MainAxisAlignment.center,
// //                                       children: [
// //                                         Row(
// //                                           mainAxisSize: MainAxisSize.max,
// //                                           children: [
// //                                             Text(
// //
// //                                               columnUsersRecord.displayName,
// //
// //                                               //
// //                                               // style: FlutterFlowTheme.subtitle1
// //                                               //     .override(
// //                                               //   fontFamily: 'Lexend Deca',
// //                                               //   color: FlutterFlowTheme
// //                                               //       .tertiaryColor,
// //                                               ),
// //
// //                                            // ),
// //                                           ],
// //                                         ),
// //                                         Row(
// //                                           mainAxisSize: MainAxisSize.max,
// //                                           children: [
// //                                             Expanded(
// //                                               child: Padding(
// //                                                 padding: EdgeInsetsDirectional
// //                                                     .fromSTEB(0, 4, 4, 0),
// //                                                 child: Text(
// //                                                   columnUsersRecord.email,
// //                                                   //
// //                                                   // style: FlutterFlowTheme
// //                                                   //     .bodyText2
// //                                                   //     .override(
// //                                                   //   fontFamily: 'Lexend Deca',
// //                                                   //   // color: FlutterFlowTheme
// //                                                   //   //     .primaryColor,
// //                                                   //   fontSize: 12,
// //                                                   //   fontWeight: FontWeight.w500,
// //                                                   // ),
// //
// //
// //                                                 ),
// //                                               ),
// //                                             )
// //                                           ],
// //                                         ),
// //                                         Expanded(
// //                                           child: Align(
// //                                             alignment:
// //                                             AlignmentDirectional(0, 0),
// //                                             child: ClipRRect(
// //                                               borderRadius:
// //                                               BorderRadius.circular(5),
// //                                               child: SwitchListTile(
// //                                                 value: switchListTileValue1 ??=
// //                                                 true,
// //                                                 onChanged: (newValue) =>
// //                                                     setState(() =>
// //                                                     switchListTileValue1 =
// //                                                         newValue),
// //                                                 title: Text(
// //                                                   'Title',
// //
// //                                                   //
// //                                                   // style: FlutterFlowTheme.title3
// //                                                   //     .override(
// //                                                   //   fontFamily: 'Lexend Deca',
// //                                                   //   fontSize: 16,
// //                                                   // ),
// //
// //
// //                                                 ),
// //                                                 subtitle: Text(
// //                                                   'Subtitle',
// //
// //                                                   //
// //                                                   // style: FlutterFlowTheme
// //                                                   //     .bodyText2
// //                                                   //     .override(
// //                                                   //   fontFamily: 'Lexend Deca',
// //                                                   // ),
// //                                                 ),
// //                                                 tileColor: Color(0xFFF5F5F5),
// //                                                 dense: false,
// //                                                 controlAffinity:
// //                                                 ListTileControlAffinity
// //                                                     .trailing,
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         Expanded(
// //                                           child: Align(
// //                                             alignment:
// //                                             AlignmentDirectional(0, 0),
// //                                             child: ClipRRect(
// //                                               borderRadius:
// //                                               BorderRadius.circular(5),
// //                                               child: SwitchListTile(
// //                                                 value: switchListTileValue2 ??=
// //                                                 true,
// //                                                 onChanged: (newValue) =>
// //                                                     setState(() =>
// //                                                     switchListTileValue2 =
// //                                                         newValue),
// //                                                 title: Text(
// //                                                   'Title',
// //                                                   //
// //                                                   // style: FlutterFlowTheme.title3
// //                                                   //     .override(
// //                                                   //   fontFamily: 'Lexend Deca',
// //                                                   //   fontSize: 16,
// //                                                   // ),
// //
// //
// //                                                 ),
// //                                                 subtitle: Text(
// //
// //                                                   'Subtitle',
// //
// //                                                   //
// //                                                   // style: FlutterFlowTheme
// //                                                   //     .bodyText2
// //                                                   //     .override(
// //                                                   //   fontFamily: 'Lexend Deca',
// //                                                   // ),
// //
// //                                                 ),
// //                                                 tileColor: Color(0xFFF5F5F5),
// //                                                 dense: false,
// //                                                 controlAffinity:
// //                                                 ListTileControlAffinity
// //                                                     .trailing,
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         Expanded(
// //                                           child: Align(
// //                                             alignment:
// //                                             AlignmentDirectional(0, 0),
// //                                             child: ClipRRect(
// //                                               borderRadius:
// //                                               BorderRadius.circular(5),
// //                                               child: SwitchListTile(
// //                                                 value: switchListTileValue3 ??=
// //                                                 true,
// //                                                 onChanged: (newValue) =>
// //                                                     setState(() =>
// //                                                     switchListTileValue3 =
// //                                                         newValue),
// //                                                 title: Text(
// //                                                   'Title',
// //                                                   //
// //                                                   // style: FlutterFlowTheme.title3
// //                                                   //     .override(
// //                                                   //   fontFamily: 'Lexend Deca',
// //                                                   //   fontSize: 16,
// //                                                   // ),
// //
// //
// //                                                 ),
// //                                                 subtitle: Text(
// //                                                   'Subtitle',
// //                                                   //
// //                                                   // style: FlutterFlowTheme
// //                                                   //     .bodyText2
// //                                                   //     .override(
// //                                                   //   fontFamily: 'Lexend Deca',
// //                                                   // ),
// //
// //                                                 ),
// //                                                 tileColor: Color(0xFFF5F5F5),
// //                                                 dense: false,
// //                                                 controlAffinity:
// //                                                 ListTileControlAffinity
// //                                                     .trailing,
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         )
// //                                       ],
// //                                     ),
// //                                   ),
// //                                   Padding(
// //                                     padding: EdgeInsetsDirectional.fromSTEB(
// //                                         0, 0, 8, 0),
// //                                     child: Column(
// //                                       mainAxisSize: MainAxisSize.max,
// //                                       mainAxisAlignment:
// //                                       MainAxisAlignment.center,
// //                                       children: [
// //                                         Icon(
// //                                           Icons.chevron_right_rounded,
// //                                           color: Color(0xFF82878C),
// //                                           size: 24,
// //                                         )
// //                                       ],
// //                                     ),
// //                                   )
// //                                 ],
// //                               ),
// //
// //
// //
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     )
// //                   ],
// //                 ),
// //               );
// //             }),
// //           );
// //         },
// //       ),
// //
// //     );
// //   }
// // }


import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:private_lesson_app/api/city_api.dart';
import 'package:private_lesson_app/api/leveleducation_api.dart';
import 'package:private_lesson_app/api/subject_api.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/city.dart';
import 'package:private_lesson_app/models/leveleducation.dart';
import 'package:private_lesson_app/models/subject.dart';
import 'package:private_lesson_app/models/user.dart';

class userPageWidget extends StatefulWidget {
  const userPageWidget({Key? key}) : super(key: key);

  @override
  _userPageWidgetState createState() => _userPageWidgetState();
}

class _userPageWidgetState extends State<userPageWidget> {



  bool _checkbox = false;


  bool _lights = false;

  late String dropDownValue1;
  late List<String> _genderList = ['male', 'female'];
  String _genderSelectedValue = "male";
  late List<City> _cityList = [];
  late int _citySelectedValue = 1;
  late List<Subject> _subjectList = [];
  late int _subjectSelectedValue = 1;
  late List<Leveleducation> _leveleducationList = [];
  late int _leveleducationSelectedValue = 1;
  late List<User> _userList = [];
  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    CityAPI.getCities().then((value) {
      setState(() {
        _cityList = value;
        if (_cityList.length > 0) _citySelectedValue = _cityList[0].id;
      });
    });
    SubjectAPI.getSubjects().then((value) {
      setState(() {
        _subjectList = value;
        if (_subjectList.length > 0) _subjectSelectedValue = _subjectList[0].id;
      });
    });
    LeveleducationAPI.getLeveleducations().then((value) {
      setState(() {
        _leveleducationList = value;
        if (_leveleducationList.length > 0) _leveleducationSelectedValue = _leveleducationList[0].id;
      });
    });
    UserAPI.getUsers().then((value) {
      setState(() {
        _userList = value;
      });
    });
  }



  @override
  Widget build(BuildContext context) {



    return Scaffold(




      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Users',
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
                child: TextFormField(
                  controller: textController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                ),
              ),


              // Expanded(
              //   child: Padding(
              //
              //     padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
              //
              //
              //     child: GridView(
              //       padding: EdgeInsets.zero,
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 4,
              //         crossAxisSpacing: 10,
              //       ),
              //       shrinkWrap: true,
              //       scrollDirection: Axis.vertical,
              //       children: [
              //
              //       ],
              //     ),
              //   ),
              // ),


              Padding(
                // padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                child: Container(

                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,

                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //3:1 -> 1:1
                        crossAxisCount: MediaQuery.of(context).size.width>1000?1:1,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 2,
                        mainAxisExtent: 200,
                    ),
                    // shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _userList.length,
                    // padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      // 1 ----
                      //

                      return new Column(
                        //return ListTile(
                        // 2---- children: [

                        children: [



                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                // padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),

                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      clipBehavior:
                                      Clip.antiAliasWithSaveLayer,
                                      // color: FlutterFlowTheme.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(50),
                                      ),
                                      child: Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            2, 2, 2, 2),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),

                                          child: Image.network(
                                            'https://picsum.photos/seed/305/600',
                                          ),


                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(

                                            'Name: ${_userList[index].name}',

                                        ),

                                        // ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(0, 4, 4, 0),
                                            child: Text(

                                              'id:  ${_userList[index].id}',
                                              // columnUsersRecord.email,


                                            ),
                                          ),
                                        )
                                      ],
                                    ),





                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(0, 4, 4, 0),

                                            child: SwitchListTile(
                                              title: const Text('Admin'),
                                              value: _lights,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  _lights = value;
                                                });
                                              },
                                              secondary: const Icon(Icons.supervised_user_circle),
                                            ),


                                          ),
                                        )
                                      ],
                                    ),

                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(0, 4, 4, 0),

                                            child: SwitchListTile(
                                              title: const Text('Teacher'),
                                              value: _lights,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  _lights = value;
                                                });
                                              },
                                              secondary: const Icon(Icons.supervised_user_circle),
                                            ),


                                          ),
                                        )
                                      ],
                                    ),


                                    //here
                                    Row(

                                      mainAxisSize: MainAxisSize.max,
                                      children: [

                                        Icon(

                                          Icons.chevron_right_rounded,
                                          color: Color(0xFF82878C),
                                          size: 24,
                                        ),

                                        Expanded(



                                          child: Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(0, 4, 4, 0),

                                            child: SwitchListTile(
                                              title: const Text('Student'),
                                              value: _lights,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  _lights = value;
                                                });
                                              },
                                              secondary: const Icon(Icons.supervised_user_circle),

                                            ),




                                          ),
                                        )
                                      ],
                                    ),



                                  ],
                                ),
                              ),



                            ],
                          ),


                        ],


                      );

                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
