import 'package:flutter/material.dart';
import 'package:private_lesson_app/constants/size_const.dart';
import 'package:private_lesson_app/models/message.dart';
import 'package:private_lesson_app/widget/form_widget/text_widget.dart';
import 'package:redis/redis.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ChatWidget extends StatefulWidget {
  ChatWidget({Key? key}) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  TextEditingController textController = TextEditingController();
  RedisConnection conn = RedisConnection();
  String txt = "";
  List<MessagesChat> listChat = [];
  ScrollController scrollController = ScrollController();
  connectToRedis() async {
    conn.connect('3.88.177.153', 6379).then((Command command) {
      PubSub pubsub = PubSub(command);
      pubsub.subscribe(["hassan"]);
      // command.send_object(["PUBLISH","hassan","banana"]);
      pubsub.getStream().listen((message) {
        setState(() {
          txt = message[2].toString();
        });
        print("message: $message");
      });
    });
  }

  moveDown() {
    scrollController.animateTo(scrollController.offset + 450,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  sendMsg() {
    setState(() {
      listChat.add(new MessagesChat(
          id: listChat.length + 1,
          message: textController.text,
          sender: "me",
          reciever: "them",
          msgTime: DateTime.now()));
      textController.text = "";
    });
    moveDown();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!kIsWeb) {
      connectToRedis();
    } else {
      print('is not supported!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                      conn
                          .connect('3.88.177.153', 6379)
                          .then((Command command) {
                        command.send_object(
                            ["PUBLISH", "hassan", textController.text]);
                      }).whenComplete(() {
                        sendMsg();
                        connectToRedis();
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
    height: 70,
    decoration: BoxDecoration(
      color: (colorContainerBox),
      borderRadius: BorderRadius.circular(10),
    ),
    // alignment: Alignment.centerLeft,
    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    child: Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          backgroundColor: (colorMainText),
          child: Text("${chatDetail.sender.substring(0, 2).toUpperCase()}"),
        ),
        Column(
          children: [
            Text("${chatDetail.message}"),
            Text("${chatDetail.msgTime}"),
          ],
        ),
        Icon(Icons.fiber_new),
      ],
    ),
  );
}
