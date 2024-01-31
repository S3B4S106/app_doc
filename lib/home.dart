import 'package:app_doc/app.dart';
import 'package:app_doc/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_doc/photo.dart';
import 'package:app_doc/photo_collection.dart';
import 'package:app_doc/photo_analysis.dart';
import 'package:google_sign_in/testing.dart';

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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                child: Material(
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
                                color: Color.fromRGBO(17, 63, 89, 1), width: 7),
                            borderRadius: BorderRadius.circular(57),
                          ),
                          child: Ink.image(
                            image: const AssetImage('assets/newpx1.png'),
                            height: 300,
                            width: 500,
                            fit: BoxFit.cover,
                          ),
                        )))),
            Container(
                child: Material(
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
                                color: Color.fromRGBO(17, 63, 89, 1), width: 7),
                            borderRadius: BorderRadius.circular(57),
                          ),
                          child: Ink.image(
                            image: const AssetImage('assets/List.png'),
                            height: 300,
                            width: 500,
                            fit: BoxFit.cover,
                          ),
                        )))),
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("image"),
                ),
              ),
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

