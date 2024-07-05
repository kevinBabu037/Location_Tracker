part of 'all_users_bloc.dart';

@immutable
sealed class AllUsersEvent {}


class GetAllUsersEvent extends AllUsersEvent {}

class DeleteUserEvent extends AllUsersEvent {
  final int id;

  DeleteUserEvent({required this.id});
}

