import 'package:ampify_admin_bloc/models/admin_chat_model.dart';
import 'package:ampify_admin_bloc/screens/chat_screen/bloc/admin_chat_bloc.dart';
import 'package:ampify_admin_bloc/screens/chat_screen/bloc/admin_chat_event.dart';
import 'package:ampify_admin_bloc/screens/chat_screen/bloc/admin_chat_state.dart';
import 'package:ampify_admin_bloc/screens/chat_screen/services/admin_chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AdminChatScreen extends StatelessWidget {
  final String chatId;

  AdminChatScreen({required this.chatId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('chats').doc(chatId).get(),
      builder: (context, snapshot) {
        String title;
        if (snapshot.connectionState == ConnectionState.waiting) {
          title = 'Loading...';
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            !snapshot.data!.exists) {
          title = 'Chat';
        } else {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          title = data['userName'] ?? 'Chat';
        }
        //Block provider
        return BlocProvider(
          create: (_) =>
              ChatBloc(AdminChatService())..add(LoadMessages(chatId)),
          child: AdminChatView(chatId: chatId, title: title),
        );
      },
    );
  }
}

class AdminChatView extends StatefulWidget {
  final String chatId;
  final String title;

  AdminChatView({required this.chatId, required this.title});

  @override
  _AdminChatViewState createState() => _AdminChatViewState();
}

class _AdminChatViewState extends State<AdminChatView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded) {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => _scrollToBottom());

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final msg = state.messages[index];
                      final isAdmin = msg.senderId == 'admin_id';
                      final formattedTime =
                          DateFormat('hh:mm a').format(msg.timestamp);

                      return Align(
                        alignment: isAdmin
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                          decoration: BoxDecoration(
                            color:
                                isAdmin ? Colors.blue[600] : Colors.grey[300],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(isAdmin ? 12 : 0),
                              bottomRight: Radius.circular(isAdmin ? 0 : 12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: isAdmin
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                msg.text,
                                style: TextStyle(
                                  color:
                                      isAdmin ? Colors.white : Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                formattedTime,
                                style: TextStyle(
                                  color:
                                      isAdmin ? Colors.white70 : Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No messages"));
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      final message = ChatMessage(
                        senderId: 'admin_id',
                        senderName: 'Admin',
                        senderEmail: 'admin@example.com',
                        senderBase64Image: '',
                        text: text,
                        timestamp: DateTime.now(),
                        isSeen: false,
                      );
                      context.read<ChatBloc>().add(
                            SendMessage(
                                chatId: widget.chatId, message: message),
                          );
                      _controller.clear();
                      _scrollToBottom();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
