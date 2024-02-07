import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  // Crear una referencia al almacenamiento
  late FirebaseStorage _storage;

  FirebaseStorageService() {
    this._storage = FirebaseStorage.instance;
  }
  // Subir la foto
  Future<Reference> uploadFile(File file, String name) async {
    final fotoRef = _storage.ref().child('fotos/$name');
    await fotoRef.putFile(file).whenComplete(() {
      print('La foto se subió correctamente.');
    });
    return fotoRef;
  }

  // Obtener ruta imagen
  Future<String> getUrl(Reference image) async {
    return await image.getDownloadURL();
  }

  void removeFile({required File file}) async {}
}