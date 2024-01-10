import 'dart:ffi';

import 'package:app_doc/features/user_auth/presentation/ResetPassword.dart';
import 'package:app_doc/features/app/splash_screen/splash_screen.dart';
import 'package:app_doc/features/user_auth/firebase_auth_implementation/firebase_options.dart';
import 'package:app_doc/home.dart';
import 'package:app_doc/features/user_auth/presentation/login.dart';
import 'package:app_doc/features/user_auth/presentation/login_email.dart';
import 'package:app_doc/features/user_auth/presentation/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:app_doc/app.dart';

MaterialColor colour(Color darkmint1) {
  final int red = darkmint1.red;
  final int green = darkmint1.green;
  final int blue = darkmint1.blue;
  final int alpha = darkmint1.alpha;

  final Map<int, Color> shades = {
    50: Color.fromARGB(alpha, red, green, blue),
    100: Color.fromARGB(alpha, red, green, blue),
    200: Color.fromARGB(alpha, red, green, blue),
    300: Color.fromARGB(alpha, red, green, blue),
    400: Color.fromARGB(alpha, red, green, blue),
    500: Color.fromARGB(alpha, red, green, blue),
    600: Color.fromARGB(alpha, red, green, blue),
    700: Color.fromARGB(alpha, red, green, blue),
    800: Color.fromARGB(alpha, red, green, blue),
    900: Color.fromARGB(alpha, red, green, blue),
  };
  return MaterialColor(darkmint1.value, shades);
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseAuth auth = FirebaseAuth.instance;
  Widget _currentScreen = LoginScreen();

// Verificar si el usuario está logueado
  User? user = auth.currentUser;

  if (user != null) {
    // El usuario está logueado
    _currentScreen = HomeScreen();
    print("El usuario está logueado con el ID ${user.uid}");
  } else {
    // El usuario no está logueado
    _currentScreen = LoginScreen();
    print("El usuario no está logueado");
  }
  runApp(MyApp(_currentScreen));
}

class MyApp extends StatelessWidget {
  Widget _currentScreen = LoginScreen();
  MyApp(Widget currentScreen) {
    _currentScreen = currentScreen;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PxPhotoPro',
      //Tema Principal, se usa cuando no está activo el modo oscuro
      theme: ThemeData(
        //Se indica que el tema tiene un brillo luminoso/claro
        brightness: Brightness.light,
        primarySwatch: colour(Color.fromRGBO(35, 93, 113, 1)),
        secondaryHeaderColor: Color.fromARGB(255, 204, 0, 255),
      ),
      //Tema Oscuro, se usa cuando se activa el modo oscuro
      darkTheme: ThemeData(
        //Se indica que el tema tiene un brillo oscuro
        brightness: Brightness.dark,
        primarySwatch: colour(Color.fromRGBO(35, 93, 113, 1)),
        secondaryHeaderColor: Color.fromARGB(255, 204, 0, 255),
      ),
      routes: {
        '/': (context) => SplashScreen(
            // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
            child: _currentScreen),
        '/login': (context) => LoginScreen(),
        '/login-email': (context) => LoginEmailScreen(),
        '/signUp': (context) => SignUpScreen(),
        '/resetPassword': (context) => ResetPasswordScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
