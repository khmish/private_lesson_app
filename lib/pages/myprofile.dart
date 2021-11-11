import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:private_lesson_app/api/user_api.dart';
import 'package:private_lesson_app/models/tutor_subs_lvl_ed.dart';
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

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
  }

// class MyprofileScreen extends StatelessWidget {
//   MyprofileScreen({Key? key}) : super(key: key);

  Future<User> checksIfLogIn() async {
    // bool isLogged = false;
    final storage = await SharedPreferences.getInstance();
    String token = storage.getString("token").toString();
    print(token + " ********************* ");
    return await UserAPI.me(token);
  }

  @override
  Widget build(BuildContext context) {
    //final myuser = ModalRoute.of(context)!.settings.arguments as User;
    // final thisuser =
    //     ModalRoute.of(context)!.settings.arguments as TutorSubsLvEd;

    User myuser =
        new User(id: -1, name: '', email: '', city: -1, phone: '', gender: '');

    checksIfLogIn().then((value) {
      myuser = value;
    });
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
        appBar: AppBar(
          title: Text('test profile'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
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
                    color: Colors.blueGrey,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Email*********',
                // 'Email: ${thisuser.email}',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black45,
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
