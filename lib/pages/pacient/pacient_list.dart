import 'package:app_doc/features/entity/pacient.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:app_doc/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_doc/features/global/commun/searchList_widget.dart';

class PacientListScreen extends StatefulWidget {
  @override
  _PacientListState createState() => _PacientListState();
}

class _PacientListState extends State<PacientListScreen> {
  List<Pacient> pacientes = [];
  late Pacient paciente;
  @override
  void initState() {
    super.initState();
  }

  //funcional methods

  void createListener(dynamic model) {
    pacientes = model.pacientes ?? [];
    pacientes.sort((a, b) => a.userName.compareTo(b.userName));
    model.addListener(() {
      if (this.mounted) {
        setState(() {
          // Your state change code goes here
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    createListener(parameters['model']);

    // Devuelve el widget solo cuando el arreglo de pacientes esté lleno
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: GlobalConfig.alternativeComplementaryColorApp),
        elevation: 10,
        centerTitle: true,
        flexibleSpace: header(),
        title: titleApp(),
        actions: <Widget>[
          IconButton(
            icon: Icon(
                color: GlobalConfig.alternativeComplementaryColorApp,
                Icons.search),
            onPressed: () {
              // Mostramos la barra de búsqueda
              showSearch(
                  context: context,
                  delegate: SearchList(pacientes, parameters['model']));
            },
          ),
        ],
      ),
      body: pacientes.isNotEmpty
          ? ListView(
              children: [
                // Listamos los clientes
                for (final paciente in pacientes)
                  ListTile(
                    textColor: GlobalConfig.textColor,
                    title: Text(paciente.userName),
                    subtitle: Text(paciente.id),
                    trailing: Text(paciente.fotos!.length.toString()),
                    onTap: () {
                      // Mostramos las fotos del cliente
                      Navigator.pushNamed(
                        context,
                        "/fotos",
                        arguments: {
                          'pacient': paciente,
                          'model': parameters['model']
                        },
                      );
                    },
                  ),
              ],
            )
          : PopScope(child: 
           Center(child:Card(margin: EdgeInsets.only(top: GlobalConfig.heightPercentage(.2),bottom: GlobalConfig.heightPercentage(.48),left: GlobalConfig.widthPercentage(.05),right: GlobalConfig.widthPercentage(.05)), color: GlobalConfig.secundaryColorApp, child: Column(children: [ListTile(title: Text("You don't have any pacients yet"),subtitle: Text('for create your first pacient please press "Create" button '),), 
           Container(
            width: GlobalConfig.widthPercentage(.6),
                child: Material(
                    color: GlobalConfig.backgroundButtonColor,
                    elevation: 13,
                    borderRadius: BorderRadius.circular(150),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                        splashColor: Colors.white70,
                        onTap: () {
                          Navigator.popAndPushNamed(context, "/newPx", arguments: {'model': parameters['model'] });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: GlobalConfig.borderColor, width: 3),
                              borderRadius: BorderRadius.circular(150),
                            ),
                            child: Column(children: [
                              Text(
                                'Create',
                                style: TextStyle(
                                    fontSize: 28,
                                    color: GlobalConfig.complementaryColorApp),
                              ),
                            ])))))],),)))
    );
  }
}
