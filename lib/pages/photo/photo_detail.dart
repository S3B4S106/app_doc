import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:app_doc/generated/l10n.dart';

class PhotoDetailScreen extends StatefulWidget {
  PhotoDetailScreen({super.key});

  @override
  _PhotoDetailScreenState createState() => _PhotoDetailScreenState();
}

class _PhotoDetailScreenState extends State<PhotoDetailScreen> {
  late Photo? photo;
  final noteController = TextEditingController();
  final focusController = FocusNode();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _note ;

  @override
  void initState() {
    super.initState();
     _prefs.then((SharedPreferences prefs){
      noteController.text =  prefs.getString(photo!.uid!) ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;

    if (parameters['image'] != null) {
      photo = parameters['image'];
      print("si entra");
    }
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: GlobalConfig.alternativeComplementaryColorApp),
          title: titleApp(),
          flexibleSpace: header(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              photo != null
                  ? Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(16),
                          height: GlobalConfig.heightPercentage(.20),
                          child: FadeInImage.memoryNetwork(
                            image: photo!.ruta,
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                          ),
                        ),
                        Text(
                            style: TextStyle(
                                color: GlobalConfig
                                    .alternativeComplementaryColorApp),
                            "Details")
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.all(8),
                            height: GlobalConfig.heightPercentage(.20),
                            child: Icon(
                              size: GlobalConfig.heightPercentage(.20),
                              Icons.square,
                              color: GlobalConfig.backgroundButtonColor,
                            )),
                        Text(
                            style: TextStyle(
                                color: GlobalConfig
                                    .alternativeComplementaryColorApp),
                            S.of(context).selectPhoto)
                      ],
                    ),
              Container(
                width: GlobalConfig.width,
                height: GlobalConfig.heightPercentage(.60),
                child: Column(children: [
                  Padding(padding: EdgeInsets.only(top: GlobalConfig.heightPercentage(.05)),child: const Text("Notes"),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: GlobalConfig.widthPercentage(.1),vertical: 8),child: TextFormField(
                    controller: noteController ,
                    focusNode: focusController ,
                    onEditingComplete: ()async {
                      final SharedPreferences prefs = await _prefs;
                      if(noteController.text != ''){
                        prefs.setString(photo!.uid!, noteController.text);
                      }else{
                        prefs.remove(photo!.uid!);
                      }
                      focusController.unfocus();
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '+ Add note',
                    ),
                  ) ,),
                  Text(formatDate(photo!.fecha,order: 3)),
                  Text("${photo!.angle??0}°"),
                  Text(photo!.template??"template"),
                  Text(photo!.tipo),
                  
                ],),
              )
            ],
          ),
        ));
  }
}
