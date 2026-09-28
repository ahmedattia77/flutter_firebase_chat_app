import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chat_app/core/routing/app_routes.dart';
import 'package:flutter_firebase_chat_app/core/theme/app_colors.dart';
import 'package:flutter_firebase_chat_app/features/athu/presentation/ui/widgets/background_gradient.dart';
import 'package:flutter_firebase_chat_app/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:flutter_firebase_chat_app/features/home/presentation/ui/widgets/custom_user_tile.dart';
import 'package:flutter_firebase_chat_app/features/home/presentation/ui/widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Chats',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu_rounded, color: AppColors.iconColor),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),

      drawer: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.currentUser != null) {
            return CustomHomeDrawer(currentUser: state.currentUser!);
          }
          return const SizedBox.shrink();
        },
      ),

      body: Stack(
        children: [
          const BackgroundGradient(),

          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeSignOutSuccess) {
                // Navigator.of(context).pushReplacementNamed('/login');
              } else if (state is HomeError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is HomeLoading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.white),
                );
              }

              if (state is HomeLoaded) {
                return SafeArea(
                  child: state.users.isEmpty
                      ? Center(
                          child: Text(
                            'No users found',
                            style: TextStyle(color: AppColors.subTitleText),
                          ),
                        )
                      : ListView.builder(
                          itemCount: state.users.length,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return CustomUserTile(
                              user: user,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.chat,
                                  arguments: user,
                                );
                              },
                            );
                          },
                        ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
