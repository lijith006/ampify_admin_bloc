import 'package:ampify_admin_bloc/authentication/admin_auth_service/auth_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'auth_state.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AdminAuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    // on<SendPasswordResetLink>((event, emit) async {
    //   emit(AuthLoading());
    //   try {
    //     await _authService.sendPasswordResetLink(event.email);
    //     emit(AuthSuccess(user: null));
    //   } catch (e) {
    //     emit(AuthError(message: e.toString()));
    //   }
    // });

    // on<LoginWithGoogle>(
    //   (event, emit) async {
    //     emit(AuthLoading());
    //     try {
    //       final userCredential = await _authService.loginWithGoogle();
    //       emit(AuthSuccess(user: userCredential?.user));
    //     } catch (e) {
    //       emit(AuthError(message: e.toString()));
    //     }
    //   },
    // );

    //SIGNUP

    on<CreateUserWithEmailAndPassword>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await _authService.signUpAdmin(
          email: event.email,
          password: event.password,
          name: event.name,
          phoneNumber: event.phoneNumber,
        );
        if (response.success) {
          emit(AuthSuccess(userId: event.email)); // Assuming user ID is email
        } else {
          emit(AuthError(message: response.errorMessage ?? 'Sign-up failed'));
        }
      } catch (e) {
        emit(AuthError(message: e.toString())); // Handle exceptions
      }
    });

    //LOGIN

    on<LoginUserWithEmailAndPassword>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await _authService.logInAdmin(
            email: event.email, password: event.password);
        if (response.success) {
          emit(AuthSuccess(userId: event.email)); // Assuming user ID is email
        } else {
          emit(AuthError(message: response.errorMessage ?? 'Login failed'));
        }
      } catch (e) {
        emit(AuthError(message: e.toString())); // Handle exceptions
      }
    });

//!signout
    on<Signout>(
      (event, emit) async {
        try {
          await _authService.logOutAdmin();
          emit(AuthInitial());
        } catch (e) {
          emit(AuthError(message: e.toString()));
        }
      },
    );
  }
}
