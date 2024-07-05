part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

final class UserSignUpEvent extends SignUpEvent{
  final UserModel user;

  UserSignUpEvent({required this.user});
}