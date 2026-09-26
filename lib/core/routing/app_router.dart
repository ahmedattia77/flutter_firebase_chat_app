import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/features/athu/presentation/cubit/auth_cubit.dart';
import 'package:flutter_firebase_chat_app/features/athu/presentation/ui/pages/auth_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
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
                return const Scaffold(body: Center(child: Text('Home ...')));
              }

              return BlocProvider(
                create: (context) => AuthCubit(),
                child: const AuthScreen(),
              );
            },
          ),
        );

      default:
        return MaterialPageRoute(builder: (context) => Text('page not found'));
    }
  }
}
