import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  // get instance of firebase auth and store
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send message
  Future<void> sendMessage(String recieverId, String message) async {
    // Get current user info
    final String curUserId = _auth.currentUser!.uid;
    final String curUserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // Create a new message
    Message newMessage = Message(
        senderId: curUserId,
        senderEmail: curUserEmail,
        recieverId: recieverId,
        message: message,
        timestamp: timestamp);

    // Contruct a chat room and its Id from user and reciever id for uniqueness
    List<String> ids = [curUserId, recieverId];
    // Since both sender are reciever are related and exclusive take them.
    ids.sort(); // unique Chat room is created by sorting and joining them with '_'.
    String chatRoomId = ids.join("_");

    // Add message to DB
    await _firestore
        .collection("chat_room")
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // Recieve message
  Stream<QuerySnapshot> getMessage(String curUserId, String recieverId) {
    // First make the chat room as above
    List<String> ids = [curUserId, recieverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
