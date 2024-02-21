class Doctor {
  String id;
  String? name;
  DateTime? dueDate;
  bool suscriptionActive;
  String suscriptionType;

  Doctor(
      {required this.id,
      required this.name,
      required this.dueDate,
      required this.suscriptionType,
      required this.suscriptionActive});

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
        id: map['id'],
        name: map['nombre'],
        dueDate: map['fechaVencimiento'],
        suscriptionActive: map['suscipcionActiva'],
        suscriptionType: map['tipoSuscripcion']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': name,
      'fechaVencimiento': dueDate != null ? dueDate?.toIso8601String() : null,
      'tipoSuscripcion': suscriptionType,
      'suscipcionActiva': suscriptionActive
    };
  }
}
