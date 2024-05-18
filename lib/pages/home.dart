import 'package:app_doc/features/firebase_services/firebase_auth_services.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:app_doc/features/model/notify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_doc/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  late final EntitysModel? _entitysModel;
  HomeScreen(EntitysModel entitysModel) {
    _entitysModel = entitysModel;
  }

  @override
  _HomeScreenState createState() => _HomeScreenState(_entitysModel);
}

class _HomeScreenState extends State<HomeScreen> {
  EntitysModel? _entitysModel;
  FirebaseAuthService _authService = FirebaseAuthService();

  _HomeScreenState(EntitysModel? entitysModel) {
    _entitysModel = entitysModel;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 10,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
                color: GlobalConfig.alternativeComplementaryColorApp,
                Icons.account_circle_rounded),
            onPressed: _openUserInfo,
          ),
          actions: [
            IconButton(
              icon: Icon(
                  color: GlobalConfig.alternativeComplementaryColorApp,
                  Icons.menu_rounded),
              onPressed: () {},
            )
          ],
          flexibleSpace: header(),
          title: titleApp()),
      body: Container(
        width: GlobalConfig.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                child: Material(
                    color: GlobalConfig.backgroundButtonColor,
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
                                  color: GlobalConfig.borderColor, width: 7),
                              borderRadius: BorderRadius.circular(57),
                            ),
                            child: Column(children: [
                              Ink.image(
                                image:
                                    const AssetImage('assets/Button5Grad.png'),
                                height: GlobalConfig.height / 2 - 150,
                                width: GlobalConfig.width - 17,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                S.of(context).newPacient,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: GlobalConfig.textColor),
                              )
                            ]))))),
            Container(
                child: Material(
                    color: GlobalConfig.backgroundButtonColor,
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
                                  color: GlobalConfig.borderColor, width: 7),
                              borderRadius: BorderRadius.circular(57),
                            ),
                            child: Column(children: [
                              Ink.image(
                                image: const AssetImage(
                                    'assets/BottonlistcleanGrad.png'),
                                height: GlobalConfig.height / 2 - 150,
                                width: GlobalConfig.width - 17,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                S.of(context).pacientsList,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: GlobalConfig.textColor),
                              )
                            ]))))),
            _authService.getUser()!.emailVerified
                ? Container()
                : TextButton(
                    onPressed: () {
                      _authService.sendEmailVerification();
                    },
                    child: Text(
                      'verificar',
                      style: TextStyle(color: Colors.white),
                    ))
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
    Navigator.pushNamed(context, "/newPx", arguments: {'model': _entitysModel});
  }

  void _openlistPx() {
    Navigator.pushNamed(context, "/listPx",
        arguments: {'model': _entitysModel});
  }

  void _openUserInfo() {
    Navigator.pushNamed(context, "/user-info",
        arguments: {'model': _entitysModel});
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