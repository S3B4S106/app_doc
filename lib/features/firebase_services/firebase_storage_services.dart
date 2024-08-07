import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  // Crear una referencia al almacenamiento
  late FirebaseStorage _storage;

  FirebaseStorageService() {
    this._storage = FirebaseStorage.instance;
  }
  // Subir la foto
  Future<String> uploadFile(File file, String name) async {
    final fotoRef = _storage.ref().child('fotos/$name');
    await fotoRef.putFile(file).whenComplete(() {
      print('La foto se subió correctamente.');
    });
    String url = await getUrl(fotoRef);
    return url;
  }

  // Obtener ruta imagen
  Future<String> getUrl(Reference image) async {
    return await image.getDownloadURL();
  }

  void removeFile({required String name}) async {
    final fotoRef = _storage.ref().child('fotos/$name');
    print(fotoRef.fullPath);
    await fotoRef.delete();
  }

  Future<void> deleteFolder(String folderPath) async {
    final storage = FirebaseStorage.instance;
    final folderRef = storage.ref().root.child('fotos/$folderPath/');
    final ListResult listResult = await folderRef.list();
    for (Reference fileRef in listResult.items) {
      await fileRef.delete();
    }
  }
}
