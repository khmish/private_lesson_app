import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/lesson.dart';
import 'package:private_lesson_app/models/message.dart';
import 'package:private_lesson_app/models/user.dart';
import 'package:private_lesson_app/widget/form_widget/text_widget.dart';
import 'package:redis/redis.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ChatWidget extends StatefulWidget {
  Lesson? lesson;
  ChatWidget({Key? key, this.lesson}) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  TextEditingController textController = TextEditingController();
  RedisConnection connPublish = RedisConnection();
  RedisConnection conn = RedisConnection();
  String room = "";
  String txt = "";
  List<MessagesChat> listChat = [];
  User myuser =
      new User(id: -1, name: "", email: "", city: -1, phone: "", gender: "");
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  connectToRedis() async {
    conn.connect('3.88.177.153', 6379).then((Command command) {
      PubSub pubsub = PubSub(command);
      room = "general";

      if (widget.lesson != null) {
        room =
            "lesson${widget.lesson!.studentId}/${widget.lesson!.teacherId}/${widget.lesson!.subjectId}";
      }
      pubsub.subscribe([room]);
      // command.send_object(["PUBLISH","hassan","banana"]);
      pubsub.getStream().listen((message) {
        setState(() {
          txt = message[2].toString();
        });
        var msg = json.decode(txt);
        receiveMsg(msg['message'], sender: msg['sender']);
        print("message: $message");
      });
    });
  }

  moveDown() {
    scrollController.animateTo(scrollController.offset + 450,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  sendMsg(String txt, {String sender = "me"}) {
    setState(() {
      listChat.add(new MessagesChat(
          id: listChat.length + 1,
          message: txt,
          sender: "$sender",
          reciever: "them",
          msgTime: DateTime.now(),
          pos: 0
          ));
      textController.text = "";
    });
    moveDown();
  }

  receiveMsg(String txt, {String sender = "me"}) {
    if (myuser.name!.toLowerCase() != sender.toLowerCase()) {
      setState(() {
        listChat.add(new MessagesChat(
            id: listChat.length + 1,
            message: txt,
            sender: "$sender",
            reciever: "them",
            msgTime: DateTime.now(),
            pos: 1
            ));
        textController.text = "";
      });
      moveDown();
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    setState(() {
      isLoading = true;
    });
    checksIfLogIn().then((userValue) {
      setState(() {
        myuser = userValue;
      });
      if (!kIsWeb) {
        connectToRedis();
      } else {
        print('is not supported!');
      }
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height < 500
                            ? MediaQuery.of(context).size.height * .77
                            : MediaQuery.of(context).size.height * .7,
                        // width: MediaQuery.of(context).size.width * .8,
                        child: ListView.builder(
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return Container(
                              child: chatItem(context, listChat[index]),
                            );
                          },
                          itemCount: listChat.length,
                        ),
                      ),
                      TextWidget.textWidget("enter message",
                          length: 250,
                          textController: textController,
                          icon: Icons.ac_unit),
                      ElevatedButton(
                        onPressed: () async {
                          if (!kIsWeb) {
                            connPublish
                                .connect('3.88.177.153', 6379)
                                .then((Command command) {
                              command.send_object([
                                "PUBLISH",
                                room,
                                jsonEncode({
                                  "message": textController.text,
                                  "sender": myuser.name,
                                })
                              ]);
                            }).whenComplete(() {
                              sendMsg(textController.text,
                                  sender: myuser.name!);
                              // connectToRedis();
                            });
                          } else {
                            print('is not supported!');
                          }
                          // sendMsg();

                          // connectToRedis();
                        },
                        child: Icon(Icons.send_rounded, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          primary: Colors.blue, // <-- Button color
                          onPrimary: Colors.red, // <-- Splash color
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

Widget chatItem(BuildContext context, MessagesChat chatDetail) {
  return Container(
      height: 100,

      // alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Stack(
        fit: StackFit.loose,
        overflow: Overflow.visible,
        children: [
          chatDetail.pos==0? Positioned(
            left: 0,
            // right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 200,
              height: 80,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${chatDetail.message}",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
          ):
          Positioned(
            // left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.greenAccent.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 200,
              height: 80,
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${chatDetail.message}",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
          ),
          chatDetail.pos==0?Positioned(
            top: -10,
            child: Container(
              child: CircleAvatar(
                backgroundColor: (colorMainText),
                child:
                    Text("${chatDetail.sender.substring(0, 2).toUpperCase()}"),
              ),
            ),
          ):Positioned(
            top: -10,
            right: 0,
            child: Container(
              child: CircleAvatar(
                backgroundColor: (colorMainText),
                child:
                    Text("${chatDetail.sender.substring(0, 2).toUpperCase()}"),
              ),
            ),
          ),
          chatDetail.pos==0?Positioned(
            bottom: -10,
            
            child: Text("${chatDetail.msgTime.toString().split(" ")[1].split(".")[0]}"),
          ):Positioned(
            bottom: -10,
            right: 0,
            child: Text("${chatDetail.msgTime.toString().split(" ")[1].split(".")[0]}"),
          )
        ],
      ));
}
// Widget chatItem(BuildContext context, MessagesChat chatDetail) {
//   return Container(
//     height: 70,
//     decoration: BoxDecoration(
//       color: (colorContainerBox),
//       borderRadius: BorderRadius.circular(10),
//     ),
//     // alignment: Alignment.centerLeft,
//     margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//     padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//     child: Row(
//       // crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         CircleAvatar(
//           backgroundColor: (colorMainText),
//           child: Text("${chatDetail.sender.substring(0, 2).toUpperCase()}"),
//         ),
//         Column(
//           children: [
//             Text("${chatDetail.message}"),
//             Text("${chatDetail.msgTime}"),
//           ],
//         ),
//         Icon(Icons.fiber_new),
//       ],
//     ),
//   );
// }
