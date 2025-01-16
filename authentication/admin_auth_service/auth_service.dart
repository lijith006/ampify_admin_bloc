// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final _auth = FirebaseAuth.instance;
//   Future<User?> createUserWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       final cred = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return cred.user;
//     } on FirebaseAuthException catch (e) {
//       exceptionHandler(e.code);
//       // print("Error: ${e.message}");
//     } catch (e) {
//       print("Unexpected error: $e");
//     }
//     return null;
//   }

//   Future<UserCredential?> loginWithGoogle() async {
//     try {
//       final googleUser = await GoogleSignIn().signIn();
//       final googleAuth = await googleUser?.authentication;
//       final cred = GoogleAuthProvider.credential(
//           idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
//       return await _auth.signInWithCredential(cred);
//     } catch (e) {
//       print(e.toString());
//     }
//     return null;
//   }

//   Future<void> sendPasswordResetLink(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   Future<User?> loginUserWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       final cred = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       return cred.user;
//     } on FirebaseAuthException catch (e) {
//       exceptionHandler(e.code);
//     } catch (e) {
//       print("Unexpected error: $e");
//     }

//     return null;
//   }

//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//       await GoogleSignIn().signOut();
//     } catch (e) {
//       print("Something went wrong");
//     }
//   }
// }

// exceptionHandler(String code) {
//   switch (code) {
//     case "invalid-credential":
//       print('Your login credentials are invalid');
//     case "weak-password":
//       print('Your password must be atleast 6 characters');
//     case "email-already-in-use":
//       print('User already exists');
//     default:
//       print('Something went wrong');
//   }
// }

// //**************************************** */

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminAuthService {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign-Up for Admin
  Future<AuthResponse> signUpAdmin({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      // Create admin user with email/password
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save the user data in Firestore (admin data)
      String userId = credential.user!.uid;
      await _firestore.collection('admins').doc(userId).set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
      }, SetOptions(merge: true)); // Merge to avoid overwriting data

      // Log successful sign up
      log('Admin user created successfully with ID: $userId');
      return AuthResponse(success: true);
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth errors
      String errorMessage = _handleAuthError(e);
      return AuthResponse(success: false, errorMessage: errorMessage);
    } catch (e) {
      log('Unexpected error during sign-up: $e');
      return AuthResponse(
          success: false, errorMessage: 'An unexpected error occurred');
    }
  }

  // Log-In for Admin
  Future<AuthResponse> logInAdmin({
    required String email,
    required String password,
  }) async {
    try {
      // Admin login with email/password
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      log('Admin signed in successfully with ID: ${credential.user!.uid}');
      return AuthResponse(success: true);
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth errors
      String errorMessage = _handleAuthError(e);
      return AuthResponse(success: false, errorMessage: errorMessage);
    } catch (e) {
      log('Unexpected error during login: $e');
      return AuthResponse(
          success: false, errorMessage: 'An unexpected error occurred');
    }
  }

  // Error handling function for FirebaseAuth
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-email':
        return 'Invalid email format';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }

  // Log Out Admin
  Future<void> logOutAdmin() async {
    await _auth.signOut();
    log('Admin logged out');
  }
}

// AuthResponse class
class AuthResponse {
  final bool success; // Indicates whether the operation was successful
  final String? errorMessage; // Holds error message (if any)

  AuthResponse({required this.success, this.errorMessage});
}
