import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chat_app/core/firebase_helper/fire_base_init.dart';
import 'package:flutter_firebase_chat_app/features/home/data/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  StreamSubscription? _messagesSubscription;

  String _getChatRoomId(String currentUserId, String otherUserId) {
    List<String> ids = [currentUserId, otherUserId];
    ids.sort();
    return ids.join('_');
  }

  void getMessages({required String receiverId}) {
    emit(ChatLoading());

    final currentUserId = FireBaseInit.auth.currentUser?.uid;
    if (currentUserId == null) {
      emit(const ChatError('User not authenticated.'));
      return;
    }

    final chatRoomId = _getChatRoomId(currentUserId, receiverId);

    _messagesSubscription?.cancel();

    _messagesSubscription = FireBaseInit.firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen(
          (snapshot) {
            final messages = snapshot.docs
                .map((doc) => MessageModel.fromMap(doc.data()))
                .toList();
            emit(ChatSuccess(messages));
          },
          onError: (error) {
            emit(ChatError('Failed to fetch messages: ${error.toString()}'));
          },
        );
  }

  Future<void> sendMessage({
    required String receiverId,
    required String messageText,
  }) async {
    if (messageText.trim().isEmpty) return;

    final currentUserId = FireBaseInit.auth.currentUser?.uid;
    if (currentUserId == null) return;

    final chatRoomId = _getChatRoomId(currentUserId, receiverId);
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final message = MessageModel(
      senderId: currentUserId,
      receiverId: receiverId,
      text: messageText.trim(),
      timestamp: timestamp,
    );

    try {
      await FireBaseInit.firestore
          .collection('chats')
          .doc(chatRoomId)
          .collection('messages')
          .add(message.toMap());
    } catch (e) {
      emit(ChatError('Failed to send message: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
