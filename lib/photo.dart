class Photo {
  String? id;
  String nombre;
  DateTime fecha;
  String tipo;
  String ruta;

  Photo({
    this.id,
    required this.nombre,
    required this.fecha,
    required this.tipo,
    required this.ruta,
  });

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'],
      nombre: map['nombre'],
      fecha: map['fecha'],
      tipo: map['tipo'],
      ruta: map['ruta'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'fecha': fecha,
      'tipo': tipo,
      'ruta': ruta,
    };
  }
}
