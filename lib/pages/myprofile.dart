import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyprofileScreen extends StatefulWidget {
  late User myuser;
  MyprofileScreen({Key? key}) : super(key: key);

  @override
  _MyprofileScreenState createState() => _MyprofileScreenState();
}

class _MyprofileScreenState extends State<MyprofileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  User myuser =
      new User(id: -1, name: '', email: '', city: -1, phone: '', gender: '');
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    checksIfLogIn().then((value) {
      setState(() {
        myuser = value;
      });
    });
  }

// class MyprofileScreen extends StatelessWidget {
//   MyprofileScreen({Key? key}) : super(key: key);

  Future<User> checksIfLogIn() async {
    // bool isLogged = false;
    final storage = await SharedPreferences.getInstance();
    String token = storage.getString("token").toString();
    print(token + " ********************* ");
    User user = await UserAPI.me(token);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    //final myuser = ModalRoute.of(context)!.settings.arguments as User;
    // final thisuser =
    //     ModalRoute.of(context)!.settings.arguments as TutorSubsLvEd;

    // checksIfLogIn().then((value) {
    //   if (value.id! > 1) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         backgroundColor: Colors.green,
    //         content: Text("you are registered!! ${value.name}"),
    //       ),
    //     );
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         backgroundColor: Colors.red,
    //         content: Text("register first to get the service!!"),
    //       ),
    //     );
    //     Navigator.of(context).pushNamed("/login");
    //   }
    // });

    // Use the Todo to create the UI.
    return Scaffold(
        
          backgroundColor: (colorAppBar),
        // appBar: AppBar(
        //   title: Text('test profile'),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: colorBG,
                    image: DecorationImage(
                        image: NetworkImage("add you image URL here "),
                        fit: BoxFit.cover)),
                child: Container(
                  width: double.infinity,
                  height: 160,
                  child: Container(
                    alignment: Alignment(0.0, 2.5),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          //"https://picsum.photos/seed/305/600"
                          "https://i.ibb.co/JzdX185/profile-male.png"),
                      radius: 60.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                // "name: ",
                'Name: ${myuser.name}',
                style: TextStyle(
                    fontSize: 25.0,
                    color: colorText,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                // 'Email*********',
                'Email: ${myuser.email}',
                style: TextStyle(
                    fontSize: 18.0,
                    color: colorText,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ));
  }
}
