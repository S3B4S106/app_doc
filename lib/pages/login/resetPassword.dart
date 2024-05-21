import 'package:app_doc/features/firebase_services/firebase_auth_services.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/commun/toast.dart';
import 'package:app_doc/features/global/commun/validate_email.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:app_doc/features/user_auth/widgets/form_container_widget.dart';
import 'package:app_doc/generated/l10n.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                "${S.of(context).labelReset} ${S.of(context).labelPassword}",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: GlobalConfig.complementaryColorApp),
              ),
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                color: GlobalConfig.complementaryColorApp,
                controller: _emailController,
                hintText: S.of(context).labelEmail,
                isPasswordField: false,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  _sendMail();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        GlobalConfig.primaryColorApp,
                        Color.fromRGBO(124, 187, 176, 1)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: isSigningUp
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "${S.of(context).labelSend} ${S.of(context).labelEmail}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMail() async {
    String email = _emailController.text;
    bool _isValidEmail = isValidEmail(email);
    if (_isValidEmail) {
      _auth.sendPasswordResetEmail(email: email);
      showToast(message: "Mail Sended");
      Navigator.pushNamed(context, "/login-email");
    } else {
      showToast(message: "Invalid Email");
    }
  }
}
