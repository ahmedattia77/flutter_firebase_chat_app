import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chat_app/core/routing/app_routes.dart';
import 'package:flutter_firebase_chat_app/features/athu/presentation/cubit/auth_cubit.dart';
import 'package:flutter_firebase_chat_app/features/athu/presentation/ui/pages/auth_screen.dart';
import 'package:flutter_firebase_chat_app/features/home/data/user_model.dart';
import 'package:flutter_firebase_chat_app/features/home/presentation/cubit/chat/chat_cubit.dart';
import 'package:flutter_firebase_chat_app/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:flutter_firebase_chat_app/features/home/presentation/ui/pages/chat_screen.dart';
import 'package:flutter_firebase_chat_app/features/home/presentation/ui/pages/home_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasData && snapshot.data != null) {
                return BlocProvider(
                  create: (context) => HomeCubit()..getHomeData(),
                  child: const HomeScreen(),
                );
              }

              return BlocProvider(
                create: (context) => AuthCubit(),
                child: const AuthScreen(),
              );
            },
          ),
        );

      case AppRoutes.chat:
        if (settings.arguments is UserModel) {
          final receiverUser = settings.arguments as UserModel;
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  ChatCubit()..getMessages(receiverId: receiverUser.uid),
              child: ChatScreen(receiverUser: receiverUser),
            ),
          );
        } else {
          print(" Failed: arguments is not recognized as UserModel!");
        }
        return _errorRoute("Invalid argument for ChatScreen");

      default:
        return _errorRoute("Page not found");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(body: Center(child: Text(message))),
    );
  }
}
