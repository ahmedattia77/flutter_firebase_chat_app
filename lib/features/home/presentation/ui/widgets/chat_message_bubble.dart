import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/core/theme/app_colors.dart';
import 'package:flutter_firebase_chat_app/features/home/data/message_model.dart';

class ChatMessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isMe ? 18 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 18),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              decoration: BoxDecoration(
                color: isMe
                    ? AppColors.gradientStart.withAlpha((0.65 * 255).round())
                    : AppColors.glassBackground,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isMe ? 18 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 18),
                ),
                border: Border.all(
                  color: isMe
                      ? AppColors.gradientStart.withAlpha((0.8 * 255).round())
                      : AppColors.glassBorder,
                  width: 1,
                ),
              ),
              child: Text(
                message.text,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  height: 1.3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
