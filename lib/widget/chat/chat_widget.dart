import 'package:flutter/material.dart';
import 'package:private_lesson_app/widget/form_widget/text_widget.dart';
import 'package:redis/redis.dart';

class ChatWidget extends StatefulWidget {
  ChatWidget({Key? key}) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  TextEditingController textController = TextEditingController();
  RedisConnection conn = RedisConnection();
  String txt = "";
  connectToRedis() async {
    conn.connect('3.88.177.153', 6379).then((Command command) {
      PubSub pubsub = PubSub(command);
      pubsub.subscribe(["hassan"]);
      // command.send_object(["PUBLISH","hassan","banana"]);
      pubsub.getStream().listen((message) {
        setState(() {
          txt = message[2].toString();
        });
        print("message: ${message}");
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectToRedis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text("$txt"),
              TextWidget.textWidget("enter message",
                  length: 250,
                  textController: textController,
                  icon: Icons.ac_unit),
              ElevatedButton(
                  onPressed: () async {
                    conn.connect('3.88.177.153', 6379).then((Command command) {
                      command.send_object(["PUBLISH", "hassan", textController.text]);
                    });
                    connectToRedis();
                  },
                  child: Text("start"))
            ],
          ),
        ),
      ),
    );
  }
}
