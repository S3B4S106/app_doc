import 'dart:io';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';
import 'package:app_doc/features/firebase_services/firebase_storage_services.dart';
import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:path_provider/path_provider.dart';
import 'package:app_doc/app.dart';
import 'package:app_doc/features/user_auth/firebase_auth_implementation/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:app_doc/photo.dart';
import 'package:app_doc/photo_collection.dart';
import 'package:app_doc/photo_analysis.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/testing.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var user;
  @override
  void initState() {
    super.initState();

    // Check if the user is authenticated

    auth.authStateChanges().listen((event) {
      setState(() {
        user = event ?? FakeUser();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 100,
              width: 100,
            ),
            Text(user!.email ?? ""),
            Text(user!.displayName ?? ""),
            MaterialButton(
              color: Colors.orange,
              child: const Text("Sign Out"),
              onPressed: _handleSignOut,
            ),
            MaterialButton(
              color: Colors.orange,
              child: const Text("Show list"),
              onPressed: () {
                Navigator.pushNamed(context, "/pacient-list");
              },
            )
          ],
        ),
      ),
    );
  }

  void _handleSignOut() {
    auth.signOut();
    Navigator.pushNamed(context, "/login");
  }

  Future<void> _handlePrueba() async {
    // FirebaseStorageService _storage = FirebaseStorageService();

    // final path = await _storage.getUrl(await _storage.uploadFile(
    //     await fileFromAssets('Wallpaper.jpg'), 'prueba.jpg'));
    // Photo newPhoto = Photo(
    //     nombre: 'prueba',
    //     fecha: DateTime.now(),
    //     ruta: path,
    //     tipo: 'Fotografia');
    FirebaseRealTimeDbService _realtimedb = FirebaseRealTimeDbService();
    // _realtimedb.addImage(newPhoto, "idPasient");
    //List<Photo> photos = _realtimedb.getAllPhotos('one');
    // // Guardar la URL en la base de datos
    // final db = FirebaseDatabase.instance;
    // var key = db.ref('prueba').push().key;

    // final foto1Ref = db.ref('fotos/one/1');
    // await foto1Ref.set({
    //   'ruta': fotoUrl,
    // });

    // Obtén la referencia a la colección "fotos"
    DatabaseReference fotosRef = FirebaseDatabase.instance.ref().child("fotos");

    // Obtén la referencia al id "one"
    DatabaseReference oneRef = fotosRef.child("one");
    oneRef.onValue.listen((DatabaseEvent event) {
      event.snapshot.children.forEach((child) {
        // Obtén el objeto foto
        dynamic foto = child.value;

        // Imprime los datos de la foto
        print(foto["id"]);
        print(foto["ruta"]);
        print(foto["clienteId"]);
      });
    });
  }
}
