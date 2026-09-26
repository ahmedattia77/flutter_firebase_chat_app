import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/features/athu/presentation/ui/widgets/auth_card.dart';
import 'package:flutter_firebase_chat_app/features/athu/presentation/ui/widgets/background_gradient.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(children: [BackgroundGradient(), AuthCard()]),
    );
  }
}
