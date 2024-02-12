import 'dart:io';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';
import 'package:app_doc/features/firebase_services/firebase_storage_services.dart';
import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:path_provider/path_provider.dart';
import 'package:app_doc/main.dart';
import 'package:app_doc/features/user_auth/firebase_auth_implementation/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/photo/photo_collection.dart';
import 'package:app_doc/features/photo/photo_analysis.dart';
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
        elevation: 10,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.account_circle_rounded),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu_rounded),
            onPressed: () {},
          )
        ],
        //backgroundColor: Color.fromRGBO(35, 93, 113, 1),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromRGBO(35, 93, 113, 1),
              Color.fromRGBO(124, 187, 176, 1)
            ],
          )),
        ),
        title: const Text("P x P h o t o P r o"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                child: Material(
                    color: Color.fromRGBO(18, 62, 89, 1),
                    elevation: 13,
                    borderRadius: BorderRadius.circular(57),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                        splashColor: Colors.white70,
                        onTap: _openNewPx,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Color.fromRGBO(17, 63, 89, 1),
                                  width: 7),
                              borderRadius: BorderRadius.circular(57),
                            ),
                            child: Column(children: [
                              Ink.image(
                                image:
                                    const AssetImage('assets/Button5Grad.png'),
                                height: MediaQuery.of(context).size.height / 2 -
                                    150,
                                width: MediaQuery.of(context).size.width - 17,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              const Text(
                                'N U E V O   P A C I E N T E',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(122, 188, 176, 1)),
                              )
                            ]))))),
            Container(
                child: Material(
                    color: Color.fromRGBO(18, 62, 89, 1),
                    elevation: 10,
                    borderRadius: BorderRadius.circular(57),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                        splashColor: Colors.black87,
                        onTap: _openlistPx,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Color.fromRGBO(17, 63, 89, 1),
                                  width: 7),
                              borderRadius: BorderRadius.circular(57),
                            ),
                            child: Column(children: [
                              Ink.image(
                                image: const AssetImage(
                                    'assets/BottonlistcleanGrad.png'),
                                height: MediaQuery.of(context).size.height / 2 -
                                    150,
                                width: MediaQuery.of(context).size.width - 17,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              const Text(
                                'L I S T A    D E    P A C I E N T E S',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(122, 188, 176, 1)),
                              )
                            ]))))),
          ],
          //color: Colors.black,
        ),
        /*child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 100,
              width: 100,
            ),
            // Text(user!.email ?? ""),
            // Text(user!.displayName ?? ""),
            MaterialButton(
              color: Colors.orange,
              child: const Text("Sign Out"),
              onPressed: _handleSignOut,
            ),
            MaterialButton(
              color: Colors.orange,
              child: const Text("Nuevo Paciente"),
              onPressed: _openNewPx,
            )
          ],
        ),*/
      ),
    );
  }

  /*void _handleSignOut() {
    auth.signOut();
    Navigator.pushNamed(context, "/login");
  }*/

  void _openNewPx() {
    Navigator.pushNamed(context, "/newPx");
  }

  void _openlistPx() {
    Navigator.pushNamed(context, "/listPx");
  }
}

/*
// Photo collection

// PhotoCollection photoCollection = PhotoCollection();

// Photos

//List<Photo> photos = [];

// Loading photos

@override
void initState() {
  super.initState();

  // Load photos from the database
  photoCollection.loadPhotos().then((photos) {
    setState(() {
      this.photos = photos;
    });
  });
}

  // Taking a photo

  void _takePhoto() async {
    // Capture the image
    ImageSource imageSource = ImageSource.camera;
    File imageFile = await ImagePicker.pickImage(source: imageSource);

    // Save the photo to the database
    if (imageFile != null) {
      Photo photo = Photo(name: imageFile.name, date: DateTime.now(), content: imageFile.path);
      photoCollection.savePhoto(photo).then((id) {
        setState(() {
          photos.add(photo);
        });
      });
    }
  }

  // Analyzing a photo

  void _analyzePhoto(Photo photo) {
    // Analyze the photo
    PhotoAnalysis analysis = PhotoAnalysis();
    analysis.analyzePhoto(photo).then((results) {
      setState(() {
        photo.results = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app_doc'),
      ),
      body: ListView.builder(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          Photo photo = photos[index
*/