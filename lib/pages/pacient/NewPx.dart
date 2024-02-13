import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:flutter/material.dart';

class NewPxScreen extends StatefulWidget {
  @override
  _NewPxScreenState createState() => _NewPxScreenState();
}

class _NewPxScreenState extends State<NewPxScreen> {
  final formKey = GlobalKey<FormState>();
  String Username = '';
  String Phone = '';
  String ID = '';
  String Date = '';
  String Age = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        //backgroundColor: Color.fromRGBO(35, 93, 113, 1),
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
            buildPhone(),
            const SizedBox(height: 20),
            buildDate(),
            const SizedBox(height: 30),
            Container(
                child: Material(
                    color: Color.fromRGBO(18, 62, 89, 1),
                    elevation: 13,
                    borderRadius: BorderRadius.circular(150),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                        splashColor: Colors.white70,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            // Si el formulario es válido, aquí puedes procesar los datos
                            // Por ejemplo, enviarlos a una base de datos
                            print('Nombre: $Username');
                            print('Edad: $Age');
                            print('Género: $Phone');
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Color.fromRGBO(17, 63, 89, 1),
                                  width: 7),
                              borderRadius: BorderRadius.circular(150),
                            ),
                            child: Row(children: [
                              Ink.image(
                                image: const AssetImage('assets/Botton2.png'),
                                height: MediaQuery.of(context).size.height / 2 -
                                    353,
                                width: MediaQuery.of(context).size.width - 85,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              const Icon(
                                Icons.check_circle_outline_outlined,
                                size: 50,
                                color: Color.fromRGBO(221, 252, 212, 1),
                              )
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
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              (value) => setState(() => Username = '');
            },
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
        onChanged: (value) => setState(() => Username = value),
      );

  Widget buildID() => TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.numbers),
          labelText: 'ID',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 6) {
            return 'Ingrese Numero de ID';
          }
          return null;
        },
        onChanged: (value) => setState(() => ID = value),
      );

  Widget buildAge() => TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.onetwothree),
          labelText: 'Age',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length > 3 || value.isEmpty) {
            return 'Ingrese Edad';
          }
          return null;
        },
        onChanged: (value) => setState(() => Age = value),
      );

  Widget buildPhone() => TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.phone_iphone),
          labelText: 'Phone',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 9) {
            return 'Ingrese numero de contacto';
          }
          return null;
        },
        onChanged: (value) => setState(() => Phone = value),
      );

  Widget buildDate() => TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.date_range_outlined),
          labelText: 'Date',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 8) {
            return 'Ingrese Nombres y Apellidos';
          }
          return null;
        },
        onChanged: (value) => setState(() => Date = value),
      );
}
