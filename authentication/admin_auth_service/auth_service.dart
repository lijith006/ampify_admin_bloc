// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AdminAuthService {
//   final _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Sign-Up for Admin
//   Future<AuthResponse> signUpAdmin({
//     required String email,
//     required String password,
//     required String name,
//     required String phoneNumber,
//   }) async {
//     try {
//       // Create admin user with email-password
//       final UserCredential credential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Save the user data in Firestore (admin data)
//       String userId = credential.user!.uid;
//       await _firestore.collection('admins').doc(userId).set({
//         'name': name,
//         'email': email,
//         'phoneNumber': phoneNumber,
//         'uid': userId,
//       }, SetOptions(merge: true)); // Merge to avoid overwriting data

//       // Log successful sign up
//       log('Admin user created successfully with ID: $userId');
//       return AuthResponse(success: true);
//     } on FirebaseAuthException catch (e) {
//       // Handle specific FirebaseAuth errors
//       String errorMessage = _handleAuthError(e);
//       return AuthResponse(success: false, errorMessage: errorMessage);
//     } catch (e) {
//       log('Unexpected error during sign-up: $e');
//       return AuthResponse(
//           success: false, errorMessage: 'An unexpected error occurred');
//     }
//   }

//   // LOG-IN ADMIN
//   Future<AuthResponse> logInAdmin({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       //ADMIN LOGIN WITH EMAIL-PASSWORD
//       final UserCredential credential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       log('Admin signed in successfully with ID: ${credential.user!.uid}');
//       return AuthResponse(success: true);
//     } on FirebaseAuthException catch (e) {
//       // Handle specific FirebaseAuth errors
//       String errorMessage = _handleAuthError(e);
//       return AuthResponse(success: false, errorMessage: errorMessage);
//     } catch (e) {
//       log('Unexpected error during login: $e');
//       return AuthResponse(
//           success: false, errorMessage: 'An unexpected error occurred');
//     }
//   }
//   //FORGOT PASSWORD

//   Future<void> sendPasswordResetLink(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   // Error handling function for FirebaseAuth
//   String _handleAuthError(FirebaseAuthException e) {
//     switch (e.code) {
//       case 'user-not-found':
//         return 'No user found with this email';
//       case 'wrong-password':
//         return 'Incorrect password';
//       case 'invalid-email':
//         return 'Invalid email format';
//       default:
//         return 'Authentication failed: ${e.message}';
//     }
//   }

//   // Log Out Admin
//   Future<void> logOutAdmin() async {
//     await _auth.signOut();
//     log('Admin logged out');
//   }
// }

// class AuthResponse {
//   final bool success;
//   final String? errorMessage;

//   AuthResponse({required this.success, this.errorMessage});
// }

//***************************************************** */

import 'dart:developer';
// import 'package:firebase_auth/firebase_auth.dart';

class AdminAuthService {
  // final _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
  //FORGOT PASSWORD

  // Future<void> sendPasswordResetLink(String email) async {
  //   try {
  //     await _auth.sendPasswordResetEmail(email: email);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Error handling function for FirebaseAuth

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
