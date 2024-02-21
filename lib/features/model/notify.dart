import 'package:app_doc/features/entity/doctor.dart';
import 'package:app_doc/features/entity/photo.dart';
import 'package:flutter/foundation.dart';
import 'package:app_doc/features/entity/pacient.dart';

class EntitysModel with ChangeNotifier {
  Doctor? doctor;
  List<Pacient>? pacientes;
  List<Photo>? fotos;
  EntitysModel() {
    doctor = null;
    pacientes = [];
    fotos = null;
  }
  Doctor? get getDoctor => doctor;
  List<Pacient>? get getPacients => pacientes;
  List<Photo>? get getPhotos => fotos;

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
