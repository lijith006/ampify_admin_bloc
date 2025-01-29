// import 'package:ampify_admin_bloc/authentication/admin_auth_service/auth_service.dart';
// import 'package:ampify_admin_bloc/common/app_colors.dart';
// import 'package:ampify_admin_bloc/widgets/custom_button.dart';
// import 'package:ampify_admin_bloc/common/custom_text_styles.dart';
// import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
// import 'package:ampify_admin_bloc/widgets/validators_widget.dart';

// import 'package:flutter/material.dart';

// class ForgotPassword extends StatefulWidget {
//   const ForgotPassword({super.key});

//   @override
//   State<ForgotPassword> createState() => _ForgotPasswordState();
// }

// class _ForgotPasswordState extends State<ForgotPassword> {
//   final _auth = AdminAuthService();
//   final _email = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         title: Text(
//           'Forgot password',
//           style: CustomTextStyles.screenHeading(),
//         ),
//         foregroundColor: Colors.white,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         shadowColor: Colors.transparent,
//       ),
//       body: Container(
//         child: SizedBox.expand(
//           child: Form(
//             key: _formKey,
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Center(
//                           child: Image.asset(
//                             'assets/images/forgotPassword.png',
//                             height: 350,
//                             width: 350,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Text('Enter email to reset password'),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     CustomTextFormField(
//                       controller: _email,
//                       labelText: 'Email',
//                       validator: Validators.validateEmail,
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     CustomButton(
//                       label: 'Send Email',
//                       onTap: () async {
//                         if (_formKey.currentState?.validate() ?? false) {
//                           bool isEmailSent =
//                               await _auth.sendPasswordResetLink(_email.text);
//                           if (isEmailSent) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text(
//                                       'An email for password reset has been sent to your registered email address.')),
//                             );
//                             Navigator.pop(context);
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text(
//                                       'Invalid email address. Password reset link not sent.')),
//                             );
//                           }
//                         }
//                         // if (_formKey.currentState?.validate() ?? false) {
//                         //   await _auth.sendPasswordResetLink(_email.text);
//                         //   ScaffoldMessenger.of(context).showSnackBar(
//                         //       const SnackBar(
//                         //           content: Text(
//                         //               'An email for password reset has been send to your email')));
//                         //   Navigator.pop(context);
//                         // }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
