import 'package:ampify_admin_bloc/models/admin_chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendAdminMessage(String chatId, ChatMessage message) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toMap());

    // Update root summary
    await _firestore.collection('chats').doc(chatId).set({
      'lastMessage': message.text,
      'lastTimestamp': Timestamp.fromDate(message.timestamp),
      'lastSender': 'admin',
      'isSeen': true,
    }, SetOptions(merge: true));
  }

  Stream<List<ChatMessage>> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessage.fromMap(doc.data()))
            .toList());
  }
}
