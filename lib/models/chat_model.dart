import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatModel with ChangeNotifier {
  String entredMessage = "";
  TextEditingController controllerMessage = TextEditingController();
  void addMessage(val) {
    entredMessage = val;
  }

  void sendMessage(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': entredMessage,
      'createdAt': Timestamp.now(),
      'username': userData['username'],
      'userId': user.uid,
      'userImage': userData['image_url']
    });
    entredMessage = "";
    controllerMessage.clear();
    notifyListeners();
  }
}
