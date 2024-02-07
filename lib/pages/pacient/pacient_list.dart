import 'package:app_doc/features/entity/pacient.dart';
import 'package:app_doc/features/entity/photo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:app_doc/features/global/commun/searchList_widget.dart';

class PacientListScreen extends StatefulWidget {
  @override
  _PacientListState createState() => _PacientListState();
}

class _PacientListState extends State<PacientListScreen> {
  // Obtén la referencia a la colección "fotos"

  DatabaseReference pacientRef =
      FirebaseDatabase.instance.ref().child("clientes");
  DatabaseReference fotosRef = FirebaseDatabase.instance.ref().child("fotos");

  var pacientes = [];
  late Pacient paciente;
  @override
  void initState() {
    super.initState();

    // Escucha el evento onValue
    DatabaseReference oneRef = pacientRef.child("m1");
    oneRef.onValue.listen((DatabaseEvent event) {
      // Actualiza el arreglo de pacientes
      pacientes = [];
      event.snapshot.children.forEach((child) {
        // Obtén el objeto foto
        dynamic pacient = child.value;
        dynamic pacientid = child.key;
        paciente = Pacient(
            id: pacient["id"],
            nombre: pacient["nombre"],
            apellido: pacient["apellido"],
            fechaNacimiento: DateTime.parse(pacient["fechaNacimiento"]),
            genero: pacient["genero"],
            fotos: []);

        fetchPhotos(pacientid, paciente);
      });
    });
  }

  //funcional methods

  void fetchPhotos(String pacientid, Pacient paciente) {
    DatabaseReference twoRef = fotosRef.child("$pacientid");
    twoRef.onValue.listen((DatabaseEvent event) {
      // Add photos to the paciente object
      setState(() {
        paciente.fotos = [];
        event.snapshot.children.forEach((element) {
          dynamic photo = element.value;
          var foto = Photo(
            id: photo["id"],
            nombre: "Fotografia",
            fecha: DateTime.now(),
            tipo: photo["clienteId"],
            ruta: photo["ruta"],
          );
          paciente.fotos.add(foto);
        });
        if (!pacientes.contains(paciente)) {
          pacientes.add(paciente);
          pacientes
              .sort((a, b) => b.fechaNacimiento.compareTo(a.fechaNacimiento));
        }
        // Update the UI after adding photos
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Devuelve el widget solo cuando el arreglo de pacientes esté lleno
    return Scaffold(
      appBar: AppBar(
        title: Text("PacientList"),
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
                    subtitle: Text("${paciente.fechaNacimiento}"),
                    trailing: Text(paciente.fotos.length.toString()),
                    onTap: () {
                      // Mostramos las fotos del cliente
                      Navigator.pushNamed(
                        context,
                        "/fotos",
                        arguments: paciente,
                      );
                    },
                  ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}