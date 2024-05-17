import 'dart:async';

import 'package:app_doc/features/entity/pacient.dart';
import 'package:app_doc/features/entity/photo.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRealTimeDbService {
  // Crear una referencia al almacenamiento
  late FirebaseDatabase _realtimeDb;
  dynamic suscriptionController;

  FirebaseRealTimeDbService() {
    _realtimeDb = FirebaseDatabase.instance;
  }

  FirebaseDatabase getDb() {
    return _realtimeDb;
  }

  Future<bool> fetchContent(String ref) async {
    final event = await _realtimeDb.ref(ref).once(DatabaseEventType.value);
    final item = event.snapshot.value != null ? true : false;
    return item;
  }

  Future<Object?> fetchOnce(String ref) async {
    final event = await _realtimeDb.ref(ref).once(DatabaseEventType.value);
    final item = event.snapshot.value;
    return item;
  }

  // Subir item
  void addItem(String ref, dynamic item,
      [String? idParent, String? idItem]) async {
    final DatabaseReference dbRef;

    if (idItem == null) {
      final key = _realtimeDb.ref(ref).push().key;
      item.uid = key;
      item = item.toMap();
      dbRef = _realtimeDb.ref('$ref/$idParent/$key');
    } else {
      item = item.toMap();
      dbRef = _realtimeDb.ref('$ref/$idItem');
    }

    await dbRef.set(item);
  }

  // Obtener ruta imagen
  void removeItem(String ref, String idParent, String idItem) async {
    final DatabaseReference dbRef;
    dbRef = _realtimeDb.ref('$ref/$idParent/$idItem');
    dbRef.remove();
  }

  List<Photo> getAllPhotos(dynamic event) {
    List<Photo> photos = [];
    for (var child in event) {
      // Obtén el objeto foto
      dynamic photo = child.value;
      var foto = Photo(
        uid: photo["uid"],
        nombre: photo["nombre"],
        fecha: DateTime.parse(photo['fecha']),
        tipo: photo["tipo"],
        ruta: photo["ruta"],
      );
      photos.add(foto);
    }
    return photos;
  }

  DatabaseReference getReference(String parentRef, String ref) {
    return _realtimeDb.ref().child(parentRef).child(ref);
  }

  List<Pacient> getAllPacients(dynamic event) {
    List<Pacient> pacientes = [];
    Pacient paciente;
    if (event == null) return pacientes;
    // Actualiza el arreglo de pacientes
    for (var child in event.entries) {
      // Obtén el objeto foto
      dynamic pacient = child.value;
      paciente = Pacient(
          id: pacient["id"],
          uid: pacient["uid"],
          userName: pacient["userName"],
          age: pacient["age"],
          bornDate: DateTime.parse(pacient["bornDate"]),
          createDate: DateTime.parse(pacient["createDate"]),
          phone: pacient["phone"],
          fotos: []);
      pacientes.add(paciente);
    }
    return pacientes;
  }

  void createSuscription(entitysModel, DatabaseReference pacientRef) {
    suscriptionController = pacientRef.onValue.listen((event) {
      final data = event.snapshot.value;
      entitysModel.pacientes = getAllPacients(data);
      if (entitysModel.pacientes != null) {
        entitysModel.pacientes!.forEach((element) {
          var photoRef = getReference("fotos", element.uid);

          photoRef.onValue.listen((event) {
            final data = event.snapshot.children;
            element.fotos = getAllPhotos(data);
            entitysModel.notify();
          });
        });
      }
    });
  }

  void cancelSuscription() {
    try {
      suscriptionController.cancel();
    } catch (e) {
      print(e);
    }
  }
}
