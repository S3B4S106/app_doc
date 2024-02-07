import 'package:app_doc/features/entity/photo.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRealTimeDbService {
  // Crear una referencia al almacenamiento
  late FirebaseDatabase _realtimeDb;

  FirebaseRealTimeDbService() {
    _realtimeDb = FirebaseDatabase.instance;
  }

  FirebaseDatabase getDb() {
    return _realtimeDb;
  }

  Future<bool> fetchOnce(String ref) async {
    final event = await _realtimeDb.ref(ref).once(DatabaseEventType.value);
    final item = event.snapshot.value != null ? true : false;
    return item;
  }

  // Subir item
  void addItem(String ref, dynamic item,
      [String? idParent, String? idItem]) async {
    final DatabaseReference dbRef;

    if (idItem == null) {
      final key = _realtimeDb.ref(ref).push().key;
      item.id = key;
      dbRef = _realtimeDb.ref('$ref/$idParent/$key');
    } else {
      dbRef = _realtimeDb.ref('$ref/$idItem');
    }

    await dbRef.set(item);
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

  DatabaseReference getReference(String parentRef, String ref) {
    return _realtimeDb.ref().child(parentRef).child(ref);
  }
}
