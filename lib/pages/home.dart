import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/testing.dart';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseRealTimeDbService dbService = FirebaseRealTimeDbService();
  var user;
  @override
  void initState() {
    super.initState();

    // Check if the user is authenticated

    auth.authStateChanges().listen((event) {
      setState(() async {
        user = event ?? FakeUser();
        var id = user.uid;
        if (!await dbService.fetchOnce("medicos/$id")) {
          dbService.addItem(
              "medicos", {"id": id, "suscription": false}, null, id);
        }
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
          onPressed: _openUserInfo,
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
                                    const AssetImage('assets/newpx1edit.png'),
                                height: MediaQuery.of(context).size.height / 2 -
                                    175,
                                width: MediaQuery.of(context).size.width - 17,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              const Text(
                                'Nuevo Paciente',
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Color.fromRGBO(122, 188, 176, 1)),
                              )
                            ]))))),
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
                            image: const AssetImage('assets/Listedit.png'),
                            height:
                                MediaQuery.of(context).size.height / 2 - 175,
                            width: MediaQuery.of(context).size.width - 17,
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

  void _openUserInfo() {
    Navigator.pushNamed(context, "/user-info",
        arguments: {'user': user, 'service': auth});
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