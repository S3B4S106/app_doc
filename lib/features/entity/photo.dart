class Photo {
  String? uid;
  String nombre;
  DateTime fecha;
  String tipo;
  String ruta;
  String? template;
  String? angle;

  Photo({
    this.uid,
    required this.nombre,
    required this.fecha,
    required this.tipo,
    required this.ruta,
    this.angle,
    this.template
  });

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      uid: map['uid'],
      nombre: map['nombre'],
      fecha: map['fecha'],
      tipo: map['tipo'],
      ruta: map['ruta'],
      angle: map['angle'],
      template: map['template']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nombre': nombre,
      'fecha': fecha.toIso8601String(),
      'tipo': tipo,
      'ruta': ruta,
    };
  }

}
