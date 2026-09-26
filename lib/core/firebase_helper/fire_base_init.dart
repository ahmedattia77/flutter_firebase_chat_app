import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseInit {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  static Future<void> initialize() async {
    await googleSignIn.initialize(
      serverClientId:
          '856067300700-2g2dln70alkoiaek9ucoisdep146gsmp.apps.googleusercontent.com',
    );
  }
}
