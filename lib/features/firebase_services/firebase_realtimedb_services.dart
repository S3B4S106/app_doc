import 'package:app_doc/features/entity/photo.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRealTimeDbService {
  // Crear una referencia al almacenamiento
  late FirebaseDatabase _realtimeDb;

  FirebaseRealTimeDbService() {
    _realtimeDb = FirebaseDatabase.instance;
  }

  // Subir la foto
  void addImage(Photo photo, String idPasient) async {
    final key = _realtimeDb.ref('fotos').push().key;
    photo.id = key;
    final fotoRef = _realtimeDb.ref('fotos/$idPasient/$key');
    await fotoRef.set(photo);
  }

  // Obtener ruta imagen
  void removeImage(String id) async {}

  List<Photo> getAllPhotos(String idPasient) {
    List<Photo> photos = List.empty();
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('fotos/$idPasient');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      photos.add(data as Photo);
    });
    return photos;
  }
}
