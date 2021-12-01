class MessagesChat {
  int id;

  String message;

  String reciever;

  String sender;
  DateTime? msgTime = DateTime.now();

  MessagesChat(
      {required this.id,
      required this.message,
      required this.sender,
      required this.reciever,
      this.msgTime});
}
