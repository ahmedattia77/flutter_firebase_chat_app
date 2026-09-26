import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chat_app/core/firebase_helper/fire_base_init.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    print('authCobit');
    try {
      if (GoogleSignIn.instance.supportsAuthenticate()) {
        final GoogleSignInAccount? user = await FireBaseInit.googleSignIn
            .authenticate();
        if (user == null) {
          emit(AuthInitial());
        }

        final GoogleSignInAuthentication googleAuth = user!.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

        UserCredential usercridetial = await FireBaseInit.auth
            .signInWithCredential(credential);
        User? firebaseUser = usercridetial.user;
        if (firebaseUser != null) {
          _saveUserToFirestore(firebaseUser);
          emit(AuthSuccess(firebaseUser.uid));
        }
      } else {
        emit(
          AuthError("sorry the platform does not support sign in with google"),
        );
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _saveUserToFirestore(User user) async {
    final userRef = FireBaseInit.firestore.collection('users').doc(user.uid);

    await userRef.set({
      'uid': user.uid,
      'name': user.displayName ?? 'new user',
      'email': user.email,
      'photoUrl': user.photoURL ?? '',
      'last_seen': DateTime.now().millisecondsSinceEpoch,
      'status': 'Online',
    }, SetOptions(merge: true));
  }
}
