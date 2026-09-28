import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/core/theme/app_colors.dart';
import 'package:flutter_firebase_chat_app/features/home/data/user_model.dart';

class ChatAppBar extends StatelessWidget {
  final UserModel receiverUser;

  const ChatAppBar({super.key, required this.receiverUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.glassBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.glassBorder, width: 1),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.white,
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.glassBorder,
                  backgroundImage: receiverUser.photoUrl.isNotEmpty
                      ? NetworkImage(receiverUser.photoUrl)
                      : null,
                  child: receiverUser.photoUrl.isEmpty
                      ? const Icon(
                          Icons.person,
                          color: AppColors.white,
                          size: 22,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        receiverUser.displayName,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        receiverUser.status,
                        style: TextStyle(
                          color: receiverUser.status.toLowerCase() == 'online'
                              ? Colors.greenAccent
                              : AppColors.subTitleText,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
