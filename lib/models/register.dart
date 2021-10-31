class Register {
  
  late String name;
  late String email;
  late String password;
  late int city;
  late String phone;
  late String gender;
  late String role;

  Register({ required this.name, required this.email,required this.password, required this.city, required this.phone,required this.gender,required this.role});

  Register.fromJson(Map<String, dynamic> json) {
    
    name = json['name'];
    email = json['email'];
    password = json['password'];
    city = json['city_id'];
    phone = json['phone'];
    gender = json['gender'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['city_id'] = this.city;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['role'] = this.role;
    return data;
  }
}