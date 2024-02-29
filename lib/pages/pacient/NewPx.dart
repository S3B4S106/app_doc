import 'package:app_doc/features/entity/pacient.dart';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/commun/toast.dart';
import 'package:app_doc/features/global/gobal_config.dart';
import 'package:app_doc/features/model/notify.dart';
import 'package:app_doc/features/firebase_services/firebase_auth_services.dart';
import 'package:flutter/material.dart';

class NewPxScreen extends StatefulWidget {
  @override
  _NewPxScreenState createState() => _NewPxScreenState();
}

class _NewPxScreenState extends State<NewPxScreen> {
  final usertextcontroller = TextEditingController();
  final idtextcontroller = TextEditingController();
  final agetextcontroller = TextEditingController();
  final dobtextcontroller = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirebaseRealTimeDbService _dbService = FirebaseRealTimeDbService();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    EntitysModel entitysModel = parameters['model'];
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        //backgroundColor: GlobalConfig.primaryColorApp,
        flexibleSpace: header(),
        title: titleApp(),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 70,
          ),
          children: [
            buildUsername(),
            const SizedBox(height: 20),
            buildID(),
            const SizedBox(height: 20),
            buildAge(),
            const SizedBox(height: 20),
            //buildPhone(),
            //const SizedBox(height: 20),
            buildDate(),
            const SizedBox(height: 30),
            Container(
                child: Material(
                    color: GlobalConfig.backgroundButtonColor,
                    elevation: 13,
                    borderRadius: BorderRadius.circular(150),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                        splashColor: Colors.white70,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            // Si el formulario es válido, aquí puedes procesar los datos
                            // Por ejemplo, enviarlos a una base de datos
                            Pacient paciente = Pacient(
                              id: idtextcontroller.text,
                              userName: usertextcontroller.text,
                              age: agetextcontroller.text,
                              phone: null,
                              bornDate: DateTime.parse(dobtextcontroller.text),
                              createDate: DateTime.now(),
                            );

                            if (!validateId(
                                entitysModel.pacientes!, paciente.id)) {
                              _dbService.addItem("clientes", paciente,
                                  _authService.getUser()!.uid);
                            } else {
                              showToast(message: "Pacieny alredy exist");
                            }
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: GlobalConfig.borderColor, width: 3),
                              borderRadius: BorderRadius.circular(150),
                            ),
                            child: const Column(children: [
                              Text(
                                'SUBMIT',
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Color.fromRGBO(221, 252, 212, 1)),
                              ),
                              /*Ink.image(
                                image: const AssetImage('assets/Darkmint.png'),
                                height: GlobalConfig.heightPercentage(.50),
                                width: MediaQuery.of(context).size.width - 85,
                                fit: BoxFit.cover,
                              ),*/
                              /*SizedBox(
                                height: 1,
                              ),
                              Icon(
                                Icons.check_circle_outline_outlined,
                                size: 50,
                                color: Color.fromRGBO(221, 252, 212, 1),
                              )*/
                            ]))))),

            /*child: ElevatedButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.check_circle_outline,
                      size: 35,
                    ))*/
          ],
        ),
      ),
    );
  }

  Widget buildUsername() => TextFormField(
        controller: usertextcontroller,
        decoration: InputDecoration(
          filled: true,
          fillColor: GlobalConfig.textColor,
          prefixIcon: Icon(Icons.person),
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => usertextcontroller.clear(),
          ),
          labelText: 'Username',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese Nombres y Apellidos';
          }
          return null;
        },
        onChanged: (value) => setState(() => usertextcontroller.text = value),
      );

  Widget buildID() => TextFormField(
        controller: idtextcontroller,
        decoration: InputDecoration(
          filled: true,
          fillColor: GlobalConfig.textColor,
          prefixIcon: Icon(Icons.numbers_sharp),
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => idtextcontroller.clear(),
          ),
          labelText: 'ID',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 6) {
            return 'Ingrese Numero de ID';
          }
          return null;
        },
        onChanged: (value) => setState(() => idtextcontroller.text = value),
      );

  Widget buildAge() => TextFormField(
        controller: agetextcontroller,
        decoration: InputDecoration(
          filled: true,
          fillColor: GlobalConfig.textColor,
          prefixIcon: Icon(Icons.onetwothree),
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => agetextcontroller.clear(),
          ),
          labelText: 'Age',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length > 3 || value.isEmpty) {
            return 'Ingrese Edad';
          }
          return null;
        },
        onChanged: (value) => setState(() => agetextcontroller.text = value),
      );

  Widget buildPhone() => TextFormField(
        controller: usertextcontroller,
        decoration: InputDecoration(
          filled: true,
          fillColor: GlobalConfig.textColor,
          prefixIcon: Icon(Icons.phone_iphone_rounded),
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => usertextcontroller.clear(),
          ),
          labelText: 'Phone',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 9) {
            return 'Ingrese numero de contacto';
          }
          return null;
        },
        onChanged: (value) => setState(() => value),
      );

  Widget buildDate() => TextFormField(
        controller: dobtextcontroller,
        decoration: InputDecoration(
          filled: true,
          fillColor: GlobalConfig.textColor,
          prefixIcon: Icon(Icons.date_range_outlined),
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => dobtextcontroller.clear(),
          ),
          labelText: 'Date',
          border: OutlineInputBorder(),
        ),
        readOnly: true,
        onTap: () {
          _selectDate();
        },
        validator: (value) {
          if (value!.length < 8) {
            return 'Ingrese Fecha de Nacimiento';
          }
          return null;
        },
        onChanged: (value) => setState(() => dobtextcontroller.text = value),
      );

  bool validateId(pacientes, id) {
    for (final item in pacientes!) {
      if (item.id == id) return true;
    }
    return false;
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1910),
        lastDate: DateTime.now());
    if (_picked != null) {
      setState(() {
        dobtextcontroller.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
