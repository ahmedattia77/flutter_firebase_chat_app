import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/features/athu/presentation/ui/widgets/background_gradient.dart';
import 'package:flutter_firebase_chat_app/features/home/presentation/ui/widgets/chat_app_bar.dart';
import 'package:flutter_firebase_chat_app/features/home/presentation/ui/widgets/chat_input_field.dart';
import 'package:flutter_firebase_chat_app/features/home/presentation/ui/widgets/chat_message_list.dart';
import 'package:flutter_firebase_chat_app/features/home/data/user_model.dart';

class ChatScreen extends StatelessWidget {
  final UserModel receiverUser;

  const ChatScreen({super.key, required this.receiverUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: Column(
              children: [
                ChatAppBar(receiverUser: receiverUser),
                Expanded(child: ChatMessagesList(receiverId: receiverUser.uid)),
                ChatInputField(receiverId: receiverUser.uid),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
