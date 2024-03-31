import 'package:chat_app/pages/chat_screen.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService authService = AuthService();

  void logOut() async {
    await Provider.of<AuthService>(context, listen: false).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("H O M E"),
        actions: [
          IconButton(
            onPressed: logOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      // Here we want to display all the chats/users except the cureently logged user
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("E R R O R");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("L O A D I N G...");
        }
        return ListView(
          // Will take the data drom docs, which is a map and convert to list
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  // Individual User list item
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: ListTile(
          title: Text(
            data['email'],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          onTap: () {
            // When the user tile is pressed go to Particular chat page
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    userName: authService.onlyUser(data['email']),
                    recieverId: data['uid'],
                    recieverEmail: data['email'],
                  ),
                ));
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
