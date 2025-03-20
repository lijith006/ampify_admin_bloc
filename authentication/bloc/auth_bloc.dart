import 'package:ampify_admin_bloc/authentication/admin_auth_service/auth_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'auth_state.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AdminAuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
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
    // Toggle password visibility
    on<TogglePasswordVisibility>((event, emit) {
      emit(AuthPasswordVisibilityChanged(event.isPasswordVisible));
    });

//!signout
    on<Signout>(
      (event, emit) async {
        try {
          emit(AuthInitial());
        } catch (e) {
          emit(AuthError(message: e.toString()));
        }
      },
    );
  }
}
