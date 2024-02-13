import 'package:app_doc/features/entity/doctor.dart';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';
import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:app_doc/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:app_doc/features/model/notify.dart';
import 'package:app_doc/pages/pacient/NewPx.dart';
import 'package:app_doc/firstpage.dart';
import 'package:app_doc/features/user_auth/presentation/ResetPassword.dart';
import 'package:app_doc/features/app/splash_screen/splash_screen.dart';
import 'package:app_doc/features/user_auth/firebase_auth_implementation/firebase_options.dart';
import 'package:app_doc/pages/photo/photos_screen.dart';
import 'package:app_doc/pages/home.dart';
import 'package:app_doc/pages/pacient/pacient_list.dart';
import 'package:app_doc/features/user_auth/presentation/login.dart';
import 'package:app_doc/features/user_auth/presentation/login_email.dart';
import 'package:app_doc/features/user_auth/presentation/sign_up.dart';
import 'package:app_doc/pages/user/user_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/* *------- C O D I G O  D E  C O L O R E S -------*
EN ESTE ESPACIO DEJARE LOS CODIGOS DE COLORES QUE SE USARAN EN GRAN PARTE DEL PROYECTO
ESTARAN ORGANIZADO DE OSCURO A CLARO SIGUIENDO EL FORMATO RGBO EN LA PALETA DARKMINT:
(18, 62, 89, 1)
(35, 93, 113, 1)
(59, 122, 137, 1)
(86, 156, 158, 1)
(122, 188, 176, 1)
(165, 219, 195, 1)
(221, 252, 212, 1)

*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuthService auth = FirebaseAuthService();
  Widget currentScreen;
  FirebaseRealTimeDbService dbService = FirebaseRealTimeDbService();
  EntitysModel entitysModel = EntitysModel();

  // Verificar si el usuario está logueado
  if (auth.getUser() != null) {
    // El usuario está logueado
    currentScreen = HomeScreen(entitysModel);

    print("El usuario está logueado con el ID ${auth.getUser()!.uid}");

    entitysModel.doctor = Doctor(
        id: auth.getUser()!.uid,
        name: "name",
        lastname: "lastname",
        dueDate: DateTime.now(),
        genero: "genero",
        suscriptionType: "prueba",
        suscriptionActive: false);
    if (!await dbService.fetchContent("medicos/${auth.getUser()!.uid}")) {
      dbService.addItem(
          "medicos", entitysModel.doctor, null, auth.getUser()!.uid);
    }

    var pacientRef =
        dbService.getReference("clientes", entitysModel.doctor!.id);

    dbService.createSuscription(entitysModel, pacientRef);
  } else {
    // El usuario no está logueado
    currentScreen = const LoginScreen();
    print("El usuario no está logueado");
  }
  runApp(MyApp(currentScreen, entitysModel));
}

class MyApp extends StatelessWidget {
  late final Widget? _currentScreen;
  late final EntitysModel? _entitysModel;
  MyApp(Widget currentScreen, EntitysModel entitysModel) {
    _currentScreen = currentScreen;
    _entitysModel = entitysModel;
  }

  @override
  Widget build(BuildContext context) {
    var colorApp = ColorScheme.fromSeed(
        brightness: MediaQuery.platformBrightnessOf(context),
        seedColor: const Color.fromARGB(255, 32, 83, 102),
        background: calculateAverageColor(const LinearGradient(
          colors: [Color.fromRGBO(7, 54, 69, 1), Color.fromRGBO(13, 13, 13, 1)],
        ).colors));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PxPhotoPro',
      //Tema Principal, se usa cuando no está activo el modo oscuro
      theme: ThemeData(
        colorScheme: colorApp,
        scaffoldBackgroundColor: colorApp.background,
      ),
      routes: {
        '/': (context) => SplashScreen(
            // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
            child: _currentScreen),
        '/login': (context) => LoginScreen(),
        '/login-email': (context) => LoginEmailScreen(),
        '/signUp': (context) => SignUpScreen(),
        '/resetPassword': (context) => ResetPasswordScreen(),
        '/home': (context) => HomeScreen(_entitysModel!),
        '/newPx': (context) => NewPxScreen(),
        '/firstpage': (context) => firstpage(),
        '/fotos': (context) => PhotosScreen(),
        '/listPx': (context) => PacientListScreen(),
        '/user-info': (context) => UserScreen(),
      },
    );
  }
}
