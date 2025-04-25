import 'package:ampify_admin_bloc/screens/chat_screen/chat_screen/admin_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminChatListScreen extends StatelessWidget {
  const AdminChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Chats")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No active chats."));
          }
// List of documents from Firestore
          //  final chats = snapshot.data!.docs;

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // final chat = chats[index].data() as Map<String, dynamic>;
              // Get the QueryDocumentSnapshot
              final doc = snapshot.data!.docs[index];
              // Extract the map of fields
              final data = doc.data() as Map<String, dynamic>;
              // Use the document ID as chatId
              final chatId = doc.id;
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(data['senderBase64Image']),
                ),
                title: Text(data['senderName']),
                subtitle: Text(
                  data['lastMessage'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: (data['isSeen'] ?? true)
                    ? null
                    : Icon(Icons.mark_chat_unread, color: Colors.red),
                onTap: () {
                  print('Admin opening chat room: $chatId');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AdminChatScreen(chatId: chatId),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
