part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {



}

final class UserLogin extends LoginEvent{
  
 final String email;
 final String password;

  UserLogin({required this.email, required this.password,});
}

