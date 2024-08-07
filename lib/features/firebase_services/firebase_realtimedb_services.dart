import 'dart:async';

import 'package:app_doc/features/entity/doctor.dart';
import 'package:app_doc/features/entity/pacient.dart';
import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/entity/plant.dart';
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
  void removeItem(String ref, String idParent, {String? idItem}) async {
    final DatabaseReference dbRef;
    dbRef = idItem != null
        ? _realtimeDb.ref('$ref/$idParent/$idItem')
        : _realtimeDb.ref('$ref/$idParent');
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
        angle: photo["angle"]?? "0",
        template: photo["template"]?? "G0"
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

  Future<Doctor?> getDoctor(String ref) async {
    dynamic snapshot = await fetchOnce(ref);
    if (snapshot != null) {
      Doctor doctor = Doctor.fromMap(snapshot);
      return doctor;
    }
    return null;
  }

  Future<List<Plant>> getAllPlants() async {
    List<Plant> plants = [];
    Plant plant;
    dynamic snapshot = await fetchOnce('planes');

    if (snapshot == null) return plants;
    // Actualiza el arreglo de pacientes
    for (var child in snapshot) {
      if (child != null) {
        dynamic currentPlant = child;
        plant = Plant(
          id: currentPlant["id"],
          limit: currentPlant["limit"],
          name: currentPlant["name"],
        );
        plants.add(plant);
      }
    }
    return plants;
  }

  void createSuscription(entitysModel, DatabaseReference pacientRef) {
    suscriptionController = pacientRef.onValue.listen((event) {
      final data = event.snapshot.value;
      entitysModel.pacientes = getAllPacients(data);
      if (entitysModel.pacientes != null) {
        entitysModel.pacientes!.forEach((element) {
          var photoRef = getReference("fotos", element.uid);

          photoRef.onValue.listen((event) {
            entitysModel.fotos = 0;
            final data = event.snapshot.children;
            element.fotos = getAllPhotos(data);
            entitysModel.fotos = entitysModel.fotos + element.fotos.length;
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
