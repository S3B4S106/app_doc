class Doctor {
  String id;
  String name;
  String lastname;
  DateTime dueDate;
  String genero;
  bool suscriptionActive;
  String suscriptionType;

  Doctor(
      {required this.id,
      required this.name,
      required this.lastname,
      required this.dueDate,
      required this.genero,
      required this.suscriptionType,
      required this.suscriptionActive});

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
        id: map['id'],
        name: map['nombre'],
        lastname: map['apellido'],
        dueDate: map['fechaVencimiento'],
        genero: map['genero'],
        suscriptionActive: map['suscipcionActiva'],
        suscriptionType: map['tipoSuscripcion']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': name,
      'apellido': lastname,
      'fechaVencimiento': dueDate.toIso8601String(),
      'genero': genero,
      'tipoSuscripcion': suscriptionType,
      'suscipcionActiva': suscriptionActive
    };
  }
}
