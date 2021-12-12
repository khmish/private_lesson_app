class Review {
  late int? id;
  late int stars;
  late int teacherId;
  late int studentId;

  Review({this.id, required this.stars, required this.teacherId, required this.studentId});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stars = json['stars'];
    teacherId = json['teacher_id'];
    studentId = json['student_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stars'] = this.stars;
    data['teacher_id'] = this.teacherId;
    data['student_id'] = this.studentId;
    return data;
  }
}