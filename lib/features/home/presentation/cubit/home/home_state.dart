part of 'home_cubit.dart';

@immutable
sealed class HomeState {
  final UserModel? currentUser;
  const HomeState({this.currentUser});
}

final class HomeInitial extends HomeState {
  const HomeInitial() : super();
}

final class HomeLoading extends HomeState {
  const HomeLoading({super.currentUser});
}

final class HomeLoaded extends HomeState {
  final List<UserModel> users;

  const HomeLoaded({required UserModel currentUser, required this.users})
    : super(currentUser: currentUser);
}

final class HomeSignOutSuccess extends HomeState {
  const HomeSignOutSuccess() : super();
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message, {super.currentUser});
}
