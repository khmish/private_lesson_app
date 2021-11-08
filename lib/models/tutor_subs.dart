class TutorSubs {
  late int? id;
  late int tutorId;
  late int subjectId;

  TutorSubs({this.id, required this.tutorId, required this.subjectId});

  TutorSubs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tutorId = json['tutor_id'];
    subjectId = json['subject_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tutor_id'] = this.tutorId;
    data['subject_id'] = this.subjectId;
    return data;
  }
}