part of 'all_users_bloc.dart';

@immutable
sealed class AllUsersState {}

  //fech all users
final class AllUsersInitial extends AllUsersState {}

final class AllUsersLoadingState extends AllUsersState {}

final class AllUsersSuccessState extends AllUsersState {
 final  List<UserModel> users;

  AllUsersSuccessState({required this.users});
}

final class AllUsersErrorState extends AllUsersState {}






