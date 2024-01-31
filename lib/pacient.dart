import 'package:app_doc/photo.dart';

class Pacient {
  String id = "";
  String nombre = "";
  String apellido = "";
  String fechaNacimiento = "";
  String genero = "";
  List<Photo> fotos = [];

  Pacient(
      {required this.id,
      required this.nombre,
      required this.apellido,
      required this.fechaNacimiento,
      required this.genero,
      required this.fotos});

  factory Pacient.fromMap(Map<String, dynamic> map) {
    return Pacient(
      id: map['id'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      fechaNacimiento: map['fechaNacimiento'],
      genero: map['genero'],
      fotos: map['fotos'].map((foto) => Photo.fromMap(foto)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'fechaNacimiento': fechaNacimiento,
      'genero': genero,
      'fotos': fotos.map((foto) => foto.toMap()).toList(),
    };
  }
}
