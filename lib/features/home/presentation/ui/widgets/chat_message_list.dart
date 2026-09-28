import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chat_app/core/theme/app_colors.dart';
import 'package:flutter_firebase_chat_app/features/home/presentation/ui/widgets/chat_message_bubble.dart';
import 'package:flutter_firebase_chat_app/features/home/presentation/cubit/chat/chat_cubit.dart';

class ChatMessagesList extends StatelessWidget {
  final String receiverId;

  const ChatMessagesList({super.key, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.white),
          );
        } else if (state is ChatSuccess) {
          if (state.messages.isEmpty) {
            return Center(
              child: Text(
                'Say Hi! 👋',
                style: TextStyle(color: AppColors.subTitleText, fontSize: 16),
              ),
            );
          }
          return ListView.builder(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              return ChatMessageBubble(
                message: message,
                isMe: message.senderId != receiverId,
              );
            },
          );
        } else if (state is ChatError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: AppColors.error),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
