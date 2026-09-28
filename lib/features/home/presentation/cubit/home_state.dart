part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final UserModel currentUser;
  final List<UserModel> users;

  HomeLoaded({required this.currentUser, required this.users});
}

final class HomeSignOutSuccess extends HomeState {}

final class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
