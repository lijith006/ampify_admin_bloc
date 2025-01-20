part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

//passwrd
// class TogglePasswordVisibility extends AuthEvent {
//   final String field;
//   TogglePasswordVisibility(this.field);
// }

// class SendPasswordResetLink extends AuthEvent {
//   final String email;

//   SendPasswordResetLink({required this.email});
// }

// class LoginWithGoogle extends AuthEvent {}

class CreateUserWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phoneNumber;

  CreateUserWithEmailAndPassword(this.name, this.phoneNumber,
      {required this.email, required this.password});
}

class LoginUserWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;
  LoginUserWithEmailAndPassword({required this.email, required this.password});
}

class Signout extends AuthEvent {}
