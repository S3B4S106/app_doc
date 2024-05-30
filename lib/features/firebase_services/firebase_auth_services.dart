import 'dart:async';

import 'package:app_doc/features/entity/doctor.dart';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';
import 'package:app_doc/features/global/commun/toast.dart';
import 'package:app_doc/features/model/notify.dart';
import 'package:app_doc/pages/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseRealTimeDbService _dbService = FirebaseRealTimeDbService();

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String name, entitysModel) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await credential.user!.updateDisplayName(name);
      await injectDependencies(entitysModel);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password, entitysModel) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await injectDependencies(entitysModel);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<String?> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  User? getUser() {
    return _auth.currentUser;
  }

  FirebaseAuth? getAuth() {
    return _auth;
  }

  Future<void> signOut(context, myModel) async {
    await _auth.signOut();
    //_dbService.cancelSuscription();
    myModel.reset();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => LoginScreen(entitysModel: myModel)),
      (route) => false,
    );
  }

  Future<void> loginWithGoogle(context, EntitysModel entitysModel) async {
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

        await _auth.signInWithCredential(credential);
        await injectDependencies(entitysModel);
        Navigator.pushNamed(context, "/home");
      }
    } catch (e) {
      showToast(message: "some error occured $e");
    }
  }

  Future<void> injectDependencies(EntitysModel entitysModel) async {
    if (!await _dbService.fetchContent("medicos/${getUser()!.uid}")) {
      _dbService.addItem("medicos", entitysModel.doctor, null, getUser()!.uid);
      entitysModel.doctor = Doctor(
          id: getUser()!.uid,
          name: getUser()!.displayName != "" && getUser()!.displayName != null
              ? getUser()!.displayName
              : getUser()!.providerData.first.displayName,
          dueDate: null,
          suscriptionType: "free",
          suscriptionActive: false);
    } else {
      entitysModel.doctor =
          await _dbService.getDoctor("medicos/${getUser()!.uid}");
    }

    var pacientRef =
        _dbService.getReference("clientes", entitysModel.doctor!.id);

    _dbService.createSuscription(entitysModel, pacientRef);
  }
}
