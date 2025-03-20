part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class TogglePasswordVisibility extends AuthEvent {
  final bool isPasswordVisible;

  TogglePasswordVisibility(this.isPasswordVisible);
}

class LoginUserWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;
  LoginUserWithEmailAndPassword({required this.email, required this.password});
}

class Signout extends AuthEvent {}
