import 'package:ampify_admin_bloc/models/admin_chat_model.dart';

abstract class ChatEvent {}

class LoadMessages extends ChatEvent {
  final String chatId;
  LoadMessages(this.chatId);
}

class SendMessage extends ChatEvent {
  final String chatId;
  final ChatMessage message;

  SendMessage({required this.chatId, required this.message});
}
