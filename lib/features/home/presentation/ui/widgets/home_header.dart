import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chat_app/core/theme/app_colors.dart';
import 'package:flutter_firebase_chat_app/features/home/data/user_model.dart';
import 'package:flutter_firebase_chat_app/features/home/presentation/cubit/home/home_cubit.dart';

class CustomHomeDrawer extends StatelessWidget {
  final UserModel currentUser;

  const CustomHomeDrawer({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.gradientStart,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.glassBackground,
              border: Border(
                right: BorderSide(color: AppColors.glassBorder, width: 1),
              ),
            ),
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: AppColors.circleOverlay,
                    backgroundImage: currentUser.photoUrl.isNotEmpty
                        ? NetworkImage(currentUser.photoUrl)
                        : null,
                    child: currentUser.photoUrl.isEmpty
                        ? Icon(Icons.person, color: AppColors.white, size: 36)
                        : null,
                  ),
                  accountName: Text(
                    currentUser.displayName,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    currentUser.email,
                    style: TextStyle(
                      color: AppColors.subTitleText,
                      fontSize: 14,
                    ),
                  ),
                ),

                Divider(color: AppColors.glassBorder),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 24.0,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: AppColors.glassBorder),
                    ),
                    tileColor: AppColors.circleOverlay.withOpacity(0.1),
                    leading: const Icon(
                      Icons.logout_rounded,
                      color: Colors.redAccent,
                    ),
                    title: const Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      context.read<HomeCubit>().signOut();
                    },
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
