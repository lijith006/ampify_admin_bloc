import 'package:flutter/material.dart';

// part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String userId;
  AuthSuccess({required this.userId});
}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}

class AuthPasswordVisibility extends AuthState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  AuthPasswordVisibility({
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
  });
}
