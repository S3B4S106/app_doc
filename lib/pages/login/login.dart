import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/firebase_services/firebase_auth_services.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:app_doc/generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  final dynamic entitysModel;
  LoginScreen({super.key, this.entitysModel});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();

/*
  @override
  void initState() {
    super.initState();

    // Check if the user is authenticated

    _authService.authStateChanges().listen((event) {
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
        elevation: 10,
        centerTitle: true,
        title: titleApp(),
        flexibleSpace: header(),
      ),
      body: SizedBox(
        width: GlobalConfig.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _googleSignInButton(),
            const SizedBox(
              height: 10,
            ),
            _appleSignInButton(),
            const SizedBox(
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
        width: GlobalConfig.widthPercentage(.9),
        child: SignInButton(
          Buttons.email,
          text: S.of(context).loginWith("Email"),
          onPressed: _handleEmailSignIn,
        ),
      ),
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        width: GlobalConfig.widthPercentage(.9),
        child: SignInButton(
          Buttons.google,
          text: S.of(context).loginWith("Google"),
          onPressed: _handleGoogleSignIn,
        ),
      ),
    );
  }

  Widget _appleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        width: GlobalConfig.widthPercentage(.9),
        child: SignInButton(
          Buttons.appleDark,
          text: S.of(context).loginWith("Apple"),
          onPressed: _handleAppleSignIn,
        ),
      ),
    );
  }

  void _handleAppleSignIn() {
    Navigator.pushNamed(context, "/home");

    /*try {
      FacebookAuthProvider _facebookAuthProvider = FacebookAuthProvider();
      _authService.signInWithProvider(_facebookAuthProvider);
    } catch (error) {
      print(error);
    }*/
  }

  void _handleGoogleSignIn() async {
    await _authService.loginWithGoogle(context, widget.entitysModel);
  }

  void _handleEmailSignIn() {
    Navigator.pushNamed(context, "/login-email",
        arguments: {'model': widget.entitysModel});
  }
}
