import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_image_model.dart';

class AuthModel with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  String username = "";
  bool isLogin = true;
  double heightContainer = 0;
  double opacityContainer = 0;
  bool isPasswordNotVisible = true;
  bool isLoading = false;
  File image = File('');
  void sumbit(BuildContext context, formKey) {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    image = context.read<UserIamgeModel>().pickedFile;

    if (isValid) {
      formKey.currentState!.save();
      loginSigup(context);
    }
  }

  void loginSigup(BuildContext ctx) async {
    UserCredential authResult;
    try {
      isLoading = true;
      notifyListeners();
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        String url = "";
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (image.path.isNotEmpty) {
          final ref = FirebaseStorage.instance
              .ref()
              .child("user_image")
              .child(authResult.user!.uid + '.jpg');

          await ref.putFile(image);
          url = await ref.getDownloadURL();
        }

        await FirebaseFirestore.instance
            .collection("users")
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'image_url': (url.isNotEmpty) ? url : '',
        });
      }

      isLoading = false;
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
      isLoading = false;
     
      notifyListeners();
      await Flushbar(
        title: 'Error',
        message: message,
        duration: Duration(seconds: 3),
        backgroundColor: Theme.of(ctx).errorColor,
      ).show(ctx);
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  void addEmail(addEmail) {
    email = addEmail;
  }

  void addPassword(addPassword) {
    password = addPassword;
  }

  void addUsername(addUsername) {
    username = addUsername;
  }

  void switchLogin() {
    isLogin = !isLogin;
    notifyListeners();
  }

  void addheightContainer() {
    (heightContainer == 0) ? heightContainer = 70 : heightContainer = 0;
    notifyListeners();
  }

  void addopacityContainer() {
    (opacityContainer == 0) ? opacityContainer = 1 : opacityContainer = 0;
    notifyListeners();
  }

  void addIsPasswordVisible() {
    isPasswordNotVisible = !isPasswordNotVisible;
    notifyListeners();
  }
}
