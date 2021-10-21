class City {
  late int id;
  late String name;
  late String countryName;

  City({required this.id, required this.name, required this.countryName});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_name'] = this.countryName;
    return data;
  }
}