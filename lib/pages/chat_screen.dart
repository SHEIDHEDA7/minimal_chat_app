import 'package:chat_app/components/components.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String recieverEmail;
  final String recieverId;
  final String userName;
  const ChatScreen({
    super.key,
    required this.recieverEmail,
    required this.recieverId,
    required this.userName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: _buildMessageList(),
          ),

          // User input and sending field
          _inputArea()
        ],
      ),
    );
  }

  // List of Messages
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: chatService.getMessage(_auth.currentUser!.uid, widget.recieverId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _messageItem(document))
              .toList(),
        );
      },
    );
  }

  // Item of the list which is single message
  Widget _messageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Alligning messages based on sender
    var alignment = (data['senderId'] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    // Chat bubble color
    var color = (data['senderId'] == _auth.currentUser!.uid)
        ? Colors.blue
        : Colors.green;

    // Actual Message
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == _auth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            // sender
            Text(
              authService.onlyUser(data['senderEmail']).toLowerCase(),
              style: kExtraSmall,
            ),
            myBox(5, 0),
            // Message
            chatBubble(data['message'], color)
          ],
        ),
      ),
    );
  }

  // Input area
  Widget _inputArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextField
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: MyTextField(
                  controller: messageController,
                  obscureText: false,
                  hint: "message..."),
            ),
          ),
          // Send button
          IconButton(
            onPressed: () {
              // Sending the message
              if (messageController.text.isNotEmpty) {
                chatService.sendMessage(
                    widget.recieverId, messageController.text);
              }
              // Clearing controller after sending
              messageController.clear();
            },
            icon: const Icon(
              Icons.keyboard_arrow_up_rounded,
              color: Colors.black,
              size: 50,
            ),
          )
        ],
      ),
    );
  }

  Widget chatBubble(String mesaage, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        mesaage,
        style: kChatText,
      ),
    );
  }
}
