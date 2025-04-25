import 'package:ampify_admin_bloc/models/admin_chat_model.dart';
import 'package:ampify_admin_bloc/screens/chat_screen/bloc/admin_chat_event.dart';
import 'package:ampify_admin_bloc/screens/chat_screen/bloc/admin_chat_state.dart';
import 'package:ampify_admin_bloc/screens/chat_screen/services/admin_chat_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final AdminChatService chatService;

  ChatBloc(this.chatService) : super(ChatInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<_ChatUpdated>(_onChatUpdated);
  }

  void _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) {
    emit(ChatLoading());
    chatService.getMessages(event.chatId).listen((messages) {
      add(_ChatUpdated(messages));
    });
  }

  void _onChatUpdated(_ChatUpdated event, Emitter<ChatState> emit) {
    // Sorting messages from oldest to newest based on timestamp
    event.messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    emit(ChatLoaded(event.messages));
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    try {
      await chatService.sendAdminMessage(event.chatId, event.message);
    } catch (e) {
      emit(ChatError('Failed to send message'));
    }
  }
}

class _ChatUpdated extends ChatEvent {
  final List<ChatMessage> messages;
  _ChatUpdated(this.messages);
}
