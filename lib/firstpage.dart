import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Flutter code sample for [PopupMenuButton].

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Rotation Angle',
      home: AccountDeletionPage(),
    );
  }
}

class AccountDeletionPage extends StatefulWidget {
  @override
  _AccountDeletionPageState createState() => _AccountDeletionPageState();
}

class _AccountDeletionPageState extends State<AccountDeletionPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _googleSignIn = GoogleSignIn();
  //final _appleSignIn = SignInWithApple();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return; // Handle the case when the user is not logged in
    }

    try {
      // Verify user identity by re-entering password
      final form = _formKey.currentState;
      if (form!.validate()) {
        final password = _passwordController.text;

        // Check if user is authenticated with email
        if (await user.providerData.first.providerId == 'email') {
          await user.reauthenticateWithCredential(
            EmailAuthProvider.credential(
                email: user.email!, password: password),
          );
        } else if (await user.providerData.first.providerId == 'google.com') {
          // Handle Google Sign In reauthentication
          final googleAccount = await _googleSignIn.signIn();
          if (googleAccount != null) {
            final googleSignInAuthentication =
                await googleAccount.authentication;
            final googleAuthCredential = GoogleAuthProvider.credential(
              idToken: googleSignInAuthentication.idToken,
              accessToken: googleSignInAuthentication.accessToken,
            );
            await user.reauthenticateWithCredential(googleAuthCredential);
          }
        } else if (await user.providerData.first.providerId == 'apple.com') {
          // Handle Apple Sign In reauthentication
          /*final appleIdCredential = await _appleSignIn.getAuthorization();
          if (appleIdCredential != null) {
            final oauthCredential = OAuthProvider.credential(
              idToken: appleIdCredential.idToken,
              accessToken: appleIdCredential.accessToken,
            );
            await user.reauthenticateWithCredential(oauthCredential);
          }
          */
        }

        // Delete user from Firebase Authentication
        await user.delete();

        // Delete user data from other storage (optional)
        // ...

        // Inform user and navigate accordingly
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cuenta eliminada correctamente.'),
          ),
        );
        Navigator.pop(context); // Go back to login or other page
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Contraseña incorrecta. Intente de nuevo.'),
          ),
        );
      } else {
        print('Error al eliminar cuenta: ${e.message}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                '¿Está seguro de que desea eliminar su cuenta?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese su contraseña';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _deleteAccount,
                child: Text('Eliminar cuenta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
