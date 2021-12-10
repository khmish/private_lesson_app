import 'package:private_lesson_app/models/tutor_subs.dart';

class TutorSubInsert {
  late List<TutorSubs> tutorSubList;

  TutorSubInsert({required this.tutorSubList});

  TutorSubInsert.fromJson(Map<String, dynamic> json) {
    if (json['tutorSubList'] != null) {
      tutorSubList = <TutorSubs>[];
      json['tutorSubList'].forEach((v) {
        tutorSubList.add(new TutorSubs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tutorSubList != null) {
      data['tutorSubList'] = this.tutorSubList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

