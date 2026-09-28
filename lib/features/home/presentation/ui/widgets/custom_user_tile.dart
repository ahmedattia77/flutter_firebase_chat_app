import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/core/theme/app_colors.dart';
import 'package:flutter_firebase_chat_app/features/home/data/user_model.dart';

class CustomUserTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;

  const CustomUserTile({super.key, required this.user, required this.onTap});

  bool get isOnline => user.status.toLowerCase() == 'online';

  String _formatLastSeen(int timestamp) {
    if (timestamp == 0) return '';
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();

    if (now.difference(date).inMinutes < 1) {
      return 'Just now';
    } else if (now.day == date.day &&
        now.month == date.month &&
        now.year == date.year) {
      final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
      final period = date.hour >= 12 ? 'PM' : 'AM';
      final minute = date.minute.toString().padLeft(2, '0');
      return '$hour:$minute $period';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.glassBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.glassBorder, width: 1),
            ),
            child: ListTile(
              onTap: onTap,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              leading: Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.circleOverlay,
                    backgroundImage: user.photoUrl.isNotEmpty
                        ? NetworkImage(user.photoUrl)
                        : null,
                    child: user.photoUrl.isEmpty
                        ? Icon(Icons.person, color: AppColors.white)
                        : null,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: isOnline ? Colors.greenAccent : Colors.grey,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                user.displayName,
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                isOnline
                    ? 'Online'
                    : 'Last seen ${_formatLastSeen(user.lastSeen)}',
                style: TextStyle(
                  color: isOnline ? Colors.greenAccent : AppColors.subTitleText,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Icon(
                Icons.chat_bubble_outline_rounded,
                color: AppColors.iconColor,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
