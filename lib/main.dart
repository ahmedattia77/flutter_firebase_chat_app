import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/core/firebase_helper/fire_base_init.dart';
import 'package:flutter_firebase_chat_app/core/routing/app_router.dart';
import 'package:flutter_firebase_chat_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FireBaseInit.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chatapp Demo',
      theme: ThemeData(
        fontFamily: 'DM',
        colorScheme: .fromSeed(seedColor: Colors.orangeAccent),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
    );
  }
}
