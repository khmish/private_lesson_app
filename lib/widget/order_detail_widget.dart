import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/lesson.dart';
import 'package:private_lesson_app/widget/form_widget/text_widget.dart';

import 'form_widget/rating_widget.dart';

class OrderDetail extends StatefulWidget {
  late Lesson lesson;
  OrderDetail({Key? key, required this.lesson}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  String studentname = "";
  String teachername = "";
  String subject = "";
  String state = "";
  String price = "";
  int rating = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentname = widget.lesson.student!.name ?? "";
    teachername = widget.lesson.teacher!.name ?? "";
    subject = widget.lesson.subject!.name;
    state = widget.lesson.state!;
    price = widget.lesson.price!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        backgroundColor: (colorContainerBox),
      ),


      // body: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: Card(
      //       elevation: 4.0,
      //       child: Column(
      //         children: [
      //           ListTile(
      //             title: Text("Details"),
      //             // subtitle: Text("Detailssss"),
      //             // trailing: Icon(Icons.favorite_outline),
      //           ),
      //           Container(
      //             child: Column(
      //               children: [
      //                 Text("Student Name: " + studentname),
      //                 Text("Teacher Name: " + teachername),
      //                 Text("Subject: " + subject),
      //                 Text("State: " + state),
      //                 Text("Price: " + price),
      //               ],
      //             ),
      //           ),
      //           Container(
      //             child: RatingInputWidget(
      //               rating: rating,
      //               selectedValue: (rate) {
      //                 setState(() {
      //                   rating = rate;
      //                 });
      //               },
      //             ),
      //           ),
      //           ButtonBar(
      //             children: [
      //               // TextButton(
      //               //   child: const Text('Change'),
      //               //   onPressed: () {/* ... */},
      //               // ),
      //               TextButton(
      //                 child: const Text('Cancel'),
      //                 onPressed: () {
      //                   /* ... */
      //                 },
      //               )
      //             ],
      //           ),
      //         ],
      //       ),
      //   ),
      // ),

      body: SingleChildScrollView(
        child: Center(
          //child: Column(
          child: Form(
            // del here if som wrong
            child: Column(
              children: [
                //------------Pic user--------------------------
                // Container(
                //   width: MediaQuery.of(context).size.width > 1000
                //       ? MediaQuery.of(context).size.width * 0.6
                //       : MediaQuery.of(context).size.width,
                //   decoration: BoxDecoration(
                //       color: colorBackGround,
                //       image: DecorationImage(
                //           image: NetworkImage("add you image URL here "),
                //           fit: BoxFit.cover)),
                //   child: Container(
                //     width: double.infinity,
                //     height: 160,
                //     child: Container(
                //
                //       // alignment: Alignment(0.0, 2.5),
                //       // child: CircleAvatar(
                //       //   backgroundImage: NetworkImage(
                //       //       "https://picsum.photos/seed/305/600"
                //       //     // "https://i.ibb.co/JzdX185/profile-male.png"
                //       //   ),
                //       //   radius: 60.0,
                //       // ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 60,
                ),
                //
                //------------Name--------------------------
                // TextWidget.textWidget("Name",
                //     length: 70,
                //     //textController: studentname,
                //
                //     icon: Icons.person_outline,
                //     keyboardTp: 0),

            //     xxx
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            //   child: TextField(
            //     Text("Student Name: " + studentname),
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(),
            //       hintText: 'Enter a search term',
            //
            //     ),
            //   ),
            // ),
            //
            //     Text("Student Name: " + studentname),

                TextFormField(
                  initialValue: studentname,
                  decoration: InputDecoration(
                    labelText: 'Student Name',
                    //errorText: 'Error message',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.offline_pin_rounded,
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                TextFormField(
                  initialValue: teachername,
                  decoration: InputDecoration(
                    labelText: 'Teacher Name',
                    //errorText: 'Error message',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.error,
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                TextFormField(
                  initialValue: subject,
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    //errorText: 'Error message',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.error,
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                TextFormField(
                  initialValue: state,
                  decoration: InputDecoration(
                    labelText: 'state',
                    //errorText: 'Error message',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.error,
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                TextFormField(
                  initialValue: price,
                  decoration: InputDecoration(
                    labelText: 'price',
                    //errorText: 'Error message',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.error,
                    ),
                  ),
                ),





                //
                // //------------Gender--------------------------
                // DrpWidget(
                //   listObject: _genderList,
                //   defalutValue: _genderSelectedValue,
                //   selectedValue: (value) {
                //     setState(() {
                //       _genderSelectedValue = value;
                //       // print(_country);
                //     });
                //   },
                //   title: "Gender",
                // ),
                //
                // //---------------City--------------------------
                // DrpCityWidget(
                //   title: "City",
                //   listObject: _cityList,
                //   defaultValue: _citySelectedValue,
                //   selectedValue: (value) {
                //     setState(() {
                //       _citySelectedValue = value;
                //       // print(_country);
                //     });
                //   },
                // ),
                //
                //
                //
                // //------------Phone--------------------------
                // TextWidget.textWidget("Phone",
                //     length: 14,
                //     textController: phoneController,
                //     icon: Icons.phone_android,
                //     keyboardTp: 2),

                // //------------Save button--------------------------
                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                //   child: ElevatedButton.icon(
                //     onPressed: () {
                //
                //       // myuser.name = nameController.text;
                //       // myuser.gender = _genderSelectedValue;
                //       // myuser.city = _citySelectedValue;
                //       // myuser.phone = phoneController.text;
                //       // UserAPI.updateUser(myuser).then((user) {
                //       //   if (myuser.id == -1) {
                //       //     ScaffoldMessenger.of(context).showSnackBar(
                //       //       SnackBar(
                //       //         backgroundColor: Colors.red,
                //       //         content: Text("Wrong something!!"),
                //       //       ),
                //       //     );
                //       //   } else {
                //       //     setState(() {
                //       //       myuser = user;
                //       //
                //       //     });
                //       //     ScaffoldMessenger.of(context).showSnackBar(
                //       //       SnackBar(
                //       //         backgroundColor: Colors.green,
                //       //         content: Text("Updated successfully!"),
                //       //       ),
                //       //     );
                //       //   }
                //       // });
                //
                //     },
                //     label: Text('Save changes'),
                //     icon: Icon(
                //       Icons.add,
                //       size: 15,
                //     ),
                //   ),
                // ),
                //


              ],
            ),
          ),
        ),
      ),



    );
  }
}
