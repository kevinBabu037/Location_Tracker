part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoadingState extends UserProfileState {}

final class UserProfileSuccessState extends UserProfileState {
  final String name;
  final  String email;

  UserProfileSuccessState({required this.name, required this.email});
}

final class UserProfileErrorState extends UserProfileState {}



