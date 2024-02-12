import 'package:app_doc/features/entity/pacient.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/commun/transversals.dart';
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
    pacientes = model.pacientes;
    pacientes.sort((a, b) => b.fechaNacimiento.compareTo(a.fechaNacimiento));
    model.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    createListener(parameters['model']);

    // Devuelve el widget solo cuando el arreglo de pacientes esté lleno
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: header(),
        title: titleApp(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Mostramos la barra de búsqueda
              showSearch(context: context, delegate: SearchList(pacientes));
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
                    title: Text("${paciente.nombre} ${paciente.apellido}"),
                    subtitle: Text(formatDate(paciente.fechaNacimiento)),
                    trailing: Text(paciente.fotos.length.toString()),
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
          : Center(child: CircularProgressIndicator()),
    );
  }
}
