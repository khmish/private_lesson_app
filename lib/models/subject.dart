import 'package:http/http.dart';

class Subject {
  late int? id;
  late String name;
  late String? pic;
  late int leveleducation;

  Subject(
      { this.id,
      required this.name,
      this.pic,
      required this.leveleducation});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pic = json['pic'];
    leveleducation = json['leveleducation_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pic'] = this.pic;
    data['leveleducation_id'] = this.leveleducation;
    return data;
  }
}
