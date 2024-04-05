import 'package:app_doc/comparative.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:app_doc/features/firebase_services/firebase_auth_services.dart';
import 'package:app_doc/features/model/notify.dart';
import 'package:app_doc/pages/pacient/NewPx.dart';
import 'package:app_doc/firstpage.dart';
import 'package:app_doc/pages/login/resetPassword.dart';
import 'package:app_doc/features/app/splash_screen/splash_screen.dart';
import 'package:app_doc/features/firebase_services/firebase_options.dart';
import 'package:app_doc/pages/photo/camera_screen.dart';
import 'package:app_doc/pages/photo/collage_screen.dart';
import 'package:app_doc/pages/photo/photo_info.dart';
import 'package:app_doc/pages/photo/photos_screen.dart';
import 'package:app_doc/pages/home.dart';
import 'package:app_doc/pages/pacient/pacient_list.dart';
import 'package:app_doc/pages/login/login.dart';
import 'package:app_doc/pages/login/login_email.dart';
import 'package:app_doc/pages/login/sign_up.dart';
import 'package:app_doc/pages/photo/preview_photo.dart';
import 'package:app_doc/pages/user/user_info.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app_doc/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuthService auth = FirebaseAuthService();
  Widget currentScreen;
  EntitysModel entitysModel = EntitysModel();
  List<CameraDescription> cameras = [];
  cameras = await availableCameras();

  // Verificar si el usuario está logueado
  if (auth.getUser() != null) {
    // El usuario está logueado
    currentScreen = HomeScreen(entitysModel);

    print("El usuario está logueado con el ID ${auth.getUser()!.uid}");
    auth.injectDependencies(entitysModel);
  } else {
    // El usuario no está logueado
    currentScreen = LoginScreen(entitysModel: entitysModel);
    print("El usuario no está logueado");
  }

  runApp(MyApp(currentScreen, entitysModel, camera: cameras.first));
}

class MyApp extends StatelessWidget {
  late final Widget? _currentScreen;
  static EntitysModel? _entitysModel;
  final CameraDescription? camera;

  MyApp(Widget currentScreen, EntitysModel entitysModel,
      {this.camera, super.key}) {
    _currentScreen = currentScreen;
    _entitysModel = entitysModel;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PxPhotoPro',
      //Tema Principal, se usa cuando no está activo el modo oscuro
      theme: ThemeData(
        colorScheme: GlobalConfig.colorApp,
        scaffoldBackgroundColor: GlobalConfig.backgroundColor,
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
        '/camera': (context) => CameraScreen(camera: camera),
        '/preview-photo': (context) => PreviewPageScreen(),
        '/photo-info': (context) => PhotoInfoPageScreen(),
        '/collage': (context) => CollageScreen(),
        '/comparative': (context) => ComparativeScreen()
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
