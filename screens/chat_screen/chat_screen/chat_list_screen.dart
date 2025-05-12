import 'package:ampify_admin_bloc/screens/chat_screen/chat_screen/admin_chat_screen.dart';
import 'package:ampify_admin_bloc/screens/chat_screen/chat_widgets/chat_image_widget.dart';
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
            .orderBy('lastTimestamp', descending: true) // ← corrected
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
            return Center(child: Text("No active chats."));

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data()! as Map<String, dynamic>;

              return ListTile(
                leading: AvatarImage(imageData: data['userImage'] as String?),
                title: Text(data['userName']), // ← use userName
                subtitle: Text(
                  data['lastMessage'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: (data['isSeen'] ?? true)
                    ? null
                    : Icon(Icons.mark_chat_unread, color: Colors.red),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AdminChatScreen(chatId: doc.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
