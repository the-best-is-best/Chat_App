import '/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
              controller: context.watch<ChatModel>().controllerMessage,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (val) => context.read<ChatModel>().addMessage(val),
            ),
          ),
          TextButton.icon(
              onPressed: () =>
                  (context.read<ChatModel>().entredMessage.trim().isEmpty)
                      ? null
                      : context.read<ChatModel>().sendMessage(context),
              icon: Icon(Icons.send),
              label: Text(''))
        ],
      ),
    );
  }
}
