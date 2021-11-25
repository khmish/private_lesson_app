class TutorSubsLvEd {
  late int? id;
  late String? name;
  late String? email;
  late String? dateOfBirth;
  late String? exceprience;
  late String? gender;
  late String? phone;
  late String? role;
  late String? pic;
  late double? rating;
  late int? cityId;
  late String? city;
  late String? price;
  late String? cert;
  late List<Subjects> subjects;
  late List<LevelEductions> levelEductions;

  TutorSubsLvEd(
      {this.id,
      this.name,
      this.email,
      this.dateOfBirth,
      this.exceprience,
      this.gender,
      this.phone,
      this.role,
      this.pic,
      this.rating,
      this.cityId,
      this.city,
      this.price,
      this.cert,
      required this.subjects,
      required this.levelEductions});

  TutorSubsLvEd.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    exceprience = json['exceprience'];
    gender = json['gender'];
    phone = json['phone'];
    role = json['role'];
    pic = json['pic'];
    rating = json['rating'];
    cityId = json['city_id'];
    city = json['city'];
    price = json['price'];
    cert = json['cert'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects.add(new Subjects.fromJson(v));
      });
    }
    if (json['levelEductions'] != null) {
      levelEductions = <LevelEductions>[];
      json['levelEductions'].forEach((v) {
        levelEductions.add(new LevelEductions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['dateOfBirth'] = this.dateOfBirth;
    data['exceprience'] = this.exceprience;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['pic'] = this.pic;
    data['rating'] = this.rating;
    data['city_id'] = this.cityId;
    data['city'] = this.city;
    data['price'] = this.price;
    data['cert'] = this.cert;
    if (this.subjects != null) {
      data['subjects'] = this.subjects.map((v) => v.toJson()).toList();
    }
    if (this.levelEductions != null) {
      data['levelEductions'] =
          this.levelEductions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  int? id;
  int? tutorId;
  int? subjectId;
  String? subject;

  Subjects({this.id, this.tutorId, this.subjectId, this.subject});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tutorId = json['tutor_id'];
    subjectId = json['subject_id'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tutor_id'] = this.tutorId;
    data['subject_id'] = this.subjectId;
    data['subject'] = this.subject;
    return data;
  }
}

class LevelEductions {
  int? id;
  int? tutorId;
  int? leveleducationId;
  String? leveleducation;

  LevelEductions(
      {this.id, this.tutorId, this.leveleducationId, this.leveleducation});

  LevelEductions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tutorId = json['tutor_id'];
    leveleducationId = json['leveleducation_id'];
    leveleducation = json['leveleducation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tutor_id'] = this.tutorId;
    data['leveleducation_id'] = this.leveleducationId;
    data['leveleducation'] = this.leveleducation;
    return data;
  }
}