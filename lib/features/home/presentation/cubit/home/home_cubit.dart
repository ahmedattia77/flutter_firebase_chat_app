import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chat_app/core/firebase_helper/fire_base_init.dart';
import 'package:flutter_firebase_chat_app/features/home/data/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  UserModel? _currentUser;

  Future<void> getHomeData() async {
    final user = FireBaseInit.auth.currentUser;
    if (user != null) {
      _currentUser = UserModel.fromFirebaseUser(user);
    }

    emit(HomeLoading(currentUser: _currentUser));

    try {
      FireBaseInit.firestore
          .collection('users')
          .snapshots()
          .listen(
            (snapshot) {
              final usersList = snapshot.docs
                  // .where((doc) => doc.id != _currentUser?.uid)
                  .map((doc) => UserModel.fromFirestore(doc.data(), doc.id))
                  .toList();

              if (_currentUser != null) {
                emit(HomeLoaded(currentUser: _currentUser!, users: usersList));
              }
            },
            onError: (error) {
              emit(
                HomeError(
                  'Failed to load users: ${error.toString()}',
                  currentUser: _currentUser,
                ),
              );
            },
          );
    } catch (e) {
      emit(
        HomeError(
          'Failed to load home data: ${e.toString()}',
          currentUser: _currentUser,
        ),
      );
    }
  }

  Future<void> signOut() async {
    emit(HomeLoading(currentUser: _currentUser));
    try {
      await _updateUserStatus();
      await Future.wait([
        FireBaseInit.auth.signOut(),
        FireBaseInit.googleSignIn.signOut(),
      ]);

      emit(const HomeSignOutSuccess());
    } catch (e) {
      emit(
        HomeError(
          'Failed to sign out: ${e.toString()}',
          currentUser: _currentUser,
        ),
      );
    }
  }

  Future<void> _updateUserStatus() async {
    final currentUser = FireBaseInit.auth.currentUser;
    await FireBaseInit.firestore
        .collection('users')
        .doc(currentUser!.uid)
        .update({
          'status': 'Offline',
          'last_seen': DateTime.now().millisecondsSinceEpoch,
        });
  }
}
