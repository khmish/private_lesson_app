class Tutor {
  late int? id;
  late int userId;
  late String titleCert;
  late String price;
  late String type;

  Tutor({this.id, required this.userId,required this.titleCert, required this.price,required this.type});

  Tutor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    titleCert = json['title_cert'];
    price = json['price'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title_cert'] = this.titleCert;
    data['price'] = this.price;
    data['type'] = this.type;
    return data;
  }
}