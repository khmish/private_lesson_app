class Lesson {
  late int? id;
  late int studentId;
  late int teacherId;
  late Student? student;
  late Student? teacher;
  late Subject? subject;
  late int subjectId;
  late int? dateExecution;
  late String? state;

  Lesson(
      {this.id,
      required this.studentId,
      required this.teacherId,
      this.student,
      this.teacher,
      this.subject,
      required this.subjectId,
       this.dateExecution,
       this.state});

  Lesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    teacherId = json['teacher_id'];
    student =
        (json['student'] != null ? new Student.fromJson(json['student']) : null)!;
    teacher =
        (json['teacher'] != null ? new Student.fromJson(json['teacher']) : null)!;
    subject =
        (json['subject'] != null ? new Subject.fromJson(json['subject']) : null)!;
    subjectId = json['subject_id'];
    dateExecution = json['date_execution'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_id'] = this.studentId;
    data['teacher_id'] = this.teacherId;
    if (this.student != null) {
      data['student'] = this.student!.toJson();
    }
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    data['subject_id'] = this.subjectId;
    data['date_execution'] = this.dateExecution;
    data['state'] = this.state;
    return data;
  }
}

class Student {
  late int id;
  late String name;
  late String email;
  late String? emailVerifiedAt;
  late int? dateOfBirth;
  late String? exceprience;
  late String gender;
  late String phone;
  late String role;
  late String? pic;
  late int cityId;
  late String? deletedAt;
  late String? createdAt;
  late String? updatedAt;

  Student(
      {required this.id,
      required this.name,
      required this.email,
      this.emailVerifiedAt,
      this.dateOfBirth,
      this.exceprience,
      required this.gender,
      required this.phone,
      required this.role,
      this.pic,
      required this.cityId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    dateOfBirth = json['dateOfBirth'];
    exceprience = json['exceprience'];
    gender = json['gender'];
    phone = json['phone'];
    role = json['role'];
    pic = json['pic'];
    cityId = json['city_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['dateOfBirth'] = this.dateOfBirth;
    data['exceprience'] = this.exceprience;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['pic'] = this.pic;
    data['city_id'] = this.cityId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Subject {
  late int id;
  late int leveleducationId;
  late String name;
  late String? pic;
  late String? deletedAt;
  late String? createdAt;
  late String? updatedAt;

  Subject(
      {required this.id,
      required this.leveleducationId,
      required this.name,
      this.pic,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leveleducationId = json['leveleducation_id'];
    name = json['name'];
    pic = json['pic'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leveleducation_id'] = this.leveleducationId;
    data['name'] = this.name;
    data['pic'] = this.pic;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}