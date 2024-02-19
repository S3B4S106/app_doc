import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/pages/login/resetPassword.dart';
import 'package:app_doc/features/global/commun/toast.dart';
import 'package:app_doc/features/firebase_services/firebase_auth_services.dart';
import 'package:app_doc/features/user_auth/widgets/form_container_widget.dart';
import 'package:app_doc/pages/login/sign_up.dart';
import 'package:app_doc/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});
  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  dynamic entitysModel;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    entitysModel = parameters['model'];
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: titleApp(),
        flexibleSpace: header(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).labelLogin,
                style:
                    const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: S.of(context).labelEmail,
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: S.of(context).labelPassword,
                isPasswordField: true,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).copyResetPassword),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      S.of(context).labelReset,
                      style: TextStyle(
                        color: Color.fromRGBO(124, 187, 176, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  _signIn();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(35, 93, 113, 1),
                        Color.fromRGBO(124, 187, 176, 1)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isSigning
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            S.of(context).labelLogin,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).copyCreateAccount),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SignUpScreen(entitysModel: entitysModel)),
                        (route) => false,
                      );
                    },
                    child: Text(
                      S.of(context).labelSignUp,
                      style: TextStyle(
                        color: Color.fromRGBO(124, 187, 176, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user =
        await _auth.signInWithEmailAndPassword(email, password, entitysModel);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "User is successfully signed in");
      Navigator.pushNamed(context, "/home");
    } else {
      showToast(message: "some error occured");
    }
  }
}
