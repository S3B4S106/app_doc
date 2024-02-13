import 'package:app_doc/features/entity/photo.dart';

class Pacient {
  String? uid;
  String id;
  String userName;
  String age;
  DateTime bornDate;
  DateTime? createDate;
  String phone;
  List<Photo>? fotos;

  Pacient(
      {this.uid,
      required this.id,
      required this.userName,
      required this.age,
      required this.bornDate,
      required this.phone,
      this.fotos,
      required this.createDate});

  factory Pacient.fromMap(Map<String, dynamic> map) {
    return Pacient(
        uid: map['uid'],
        id: map['id'],
        userName: map['userName'],
        age: map['age'],
        bornDate: map['bornDate'],
        phone: map['phone'],
        fotos: map['fotos'].map((foto) => Photo.fromMap(foto)).toList(),
        createDate: DateTime.now());
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'id': id,
      'userName': userName,
      'age': age,
      'bornDate': bornDate.toIso8601String(),
      'phone': phone,
      'createDate': createDate!.toIso8601String()
    };
  }
}
