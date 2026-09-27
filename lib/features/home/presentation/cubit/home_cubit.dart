import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chat_app/core/firebase_helper/fire_base_init.dart';
import 'package:flutter_firebase_chat_app/features/home/data/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getHomeData() {
    emit(HomeLoading());
    try {
      final user = FireBaseInit.auth.currentUser;

      if (user == null) {
        emit(HomeError('No authenticated user found.'));
        return;
      }

      final currentUserModel = UserModel.fromFirebaseUser(user);

      FireBaseInit.firestore
          .collection('users')
          .snapshots()
          .listen(
            (snapshot) {
              final usersList = snapshot.docs.map((doc) {
                return UserModel.fromFirestore(doc.data(), doc.id);
              }).toList();

              emit(HomeLoaded(currentUser: currentUserModel, users: usersList));
            },
            onError: (error) {
              emit(HomeError('Failed to load users: ${error.toString()}'));
            },
          );
    } catch (e) {
      emit(HomeError('Failed to load home data: ${e.toString()}'));
    }
  }

  Future<void> signOut() async {
    emit(HomeLoading());
    try {
      await Future.wait([
        FireBaseInit.auth.signOut(),
        FireBaseInit.googleSignIn.signOut(),
      ]);
      emit(HomeSignOutSuccess());
    } catch (e) {
      emit(HomeError('Failed to sign out: ${e.toString()}'));
    }
  }
}
