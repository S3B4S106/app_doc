import 'package:app_doc/features/entity/doctor.dart';
import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/entity/plant.dart';
import 'package:flutter/foundation.dart';
import 'package:app_doc/features/entity/pacient.dart';

class EntitysModel with ChangeNotifier {
  Doctor? doctor;
  List<Pacient>? pacientes;
  int? fotos;
  List<Plant>? planes;
  EntitysModel() {
    doctor = null;
    pacientes = [];
    fotos = 0;
    planes = [];
  }
  Doctor? get getDoctor => doctor;
  List<Pacient>? get getPacients => pacientes;
  int? get getPhotos => fotos;
  Plant? getPlan(id) {
    for (var plan in planes!) {
      if (plan.id == id) {
        return plan;
      }
    }
    return null;
  }

  // void setDoctor(var newva) {
  //   doctor = newva;
  //   notifyListeners();
  // }

  // void setPacients(var newva) {
  //   pacientes = newva;
  //   notifyListeners();
  // }

  // void setPhotos(var newva) {
  //   fotos = newva;
  //   notifyListeners();
  // }
  void reset() {
    doctor = null;
    pacientes = [];
    fotos = null;
    notify();
  }

  void notify() {
    notifyListeners();
  }
}
