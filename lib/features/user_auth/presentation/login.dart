import 'package:app_doc/features/global/commun/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? user;
/*
  @override
  void initState() {
    super.initState();

    // Check if the user is authenticated

    _firebaseAuth.authStateChanges().listen((event) {
      setState(() {
        user = event;
      });
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("PxPhotoPro"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _googleSignInButton(),
            SizedBox(
              height: 10,
            ),
            _facebookSignInButton(),
            SizedBox(
              height: 10,
            ),
            _emailSignInButton()
          ],
        ),
      ),
    );
  }

  Widget _emailSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.email,
          text: "Sign up With Email",
          onPressed: _handleEmailSignIn,
        ),
      ),
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google,
          text: "Sign up With Google",
          onPressed: _handleGoogleSignIn,
        ),
      ),
    );
  }

  Widget _facebookSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.facebook,
          text: "Sign up With Facebook",
          onPressed: _handleFacebookSignIn,
        ),
      ),
    );
  }

  void _handleFacebookSignIn() {
    Navigator.pushNamed(context, "/home");

    /*try {
      FacebookAuthProvider _facebookAuthProvider = FacebookAuthProvider();
      _firebaseAuth.signInWithProvider(_facebookAuthProvider);
    } catch (error) {
      print(error);
    }*/
  }

  void _handleGoogleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        Navigator.pushNamed(context, "/home");
      }
    } catch (e) {
      showToast(message: "some error occured $e");
    }
  }

  void _handleEmailSignIn() {
    Navigator.pushNamed(context, "/login-email");
  }
}
