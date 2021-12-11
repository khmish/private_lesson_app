class MessagesChat {
  int id;

  String message;

  String reciever;

  String sender;
  DateTime? msgTime = DateTime.now();
  int? pos;

  MessagesChat(
      {required this.id,
      required this.message,
      required this.sender,
      required this.reciever,
      this.msgTime,
      this.pos
      });
}
