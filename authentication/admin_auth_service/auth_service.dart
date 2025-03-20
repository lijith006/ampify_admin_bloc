import 'dart:developer';

class AdminAuthService {
  // LOG-IN ADMIN
  Future<AuthResponse> logInAdmin({
    required String email,
    required String password,
  }) async {
    if (email == 'lijith006@gmail.com' && password == 'admin123') {
      return AuthResponse(success: true);
    } else {
      return AuthResponse(
          success: false, errorMessage: 'Invalid email or password');
    }
  }

  // Log Out Admin
  Future<void> logOutAdmin() async {
    // await _auth.signOut();
    log('Admin logged out');
  }
}

class AuthResponse {
  final bool success;
  final String? errorMessage;

  AuthResponse({required this.success, this.errorMessage});
}
