class User {
  late int id;
  late String name;
  late String email;
  late int city;
  late String phone;
  late String gender;

  User({required this.id, required this.name, required this.email, required this.city, required this.phone,required this.gender});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    city = json['city_id'];
    phone = json['phone'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['city_id'] = this.city;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    return data;
  }
}