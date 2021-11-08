class TutorLeveleducation {
  late int? id;
  late int tutorId;
  late int leveleducationId;

  TutorLeveleducation({this.id, required this.tutorId, required this.leveleducationId});

  TutorLeveleducation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tutorId = json['tutor_id'];
    leveleducationId = json['leveleducation_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tutor_id'] = this.tutorId;
    data['leveleducation_id'] = this.leveleducationId;
    return data;
  }
}