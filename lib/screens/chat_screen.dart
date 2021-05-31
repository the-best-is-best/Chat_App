import 'package:chat_app/models/user_image_model.dart';
import 'package:provider/provider.dart';

import '../widgets/chat/new_message.dart';
import '../widgets/chat/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TBIB Chat"), actions: [
        DropdownButton(
          icon: Icon(Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color),
          items: [
            DropdownMenuItem(
              child: Row(
                children: [
                  Icon(
                    Icons.exit_to_app,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Logout'),
                ],
              ),
              value: 'logout',
            ),
          ],
          onChanged: (itemIdentifier) {
            if (itemIdentifier == "logout") {
              context.read<UserIamgeModel>().removeImage();
              FirebaseAuth.instance.signOut();
            }
          },
        ),
      ]),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
