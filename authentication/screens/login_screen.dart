// import 'package:ampify_admin_bloc/authentication/bloc/auth_bloc.dart';
// import 'package:ampify_admin_bloc/authentication/bloc/auth_state.dart';
// import 'package:ampify_admin_bloc/authentication/screens/forgot_password.dart';
// import 'package:ampify_admin_bloc/common/app_colors.dart';
// import 'package:ampify_admin_bloc/screens/admin_panel/admin_dashboard.dart';
// import 'package:ampify_admin_bloc/widgets/custom_button.dart';
// import 'package:ampify_admin_bloc/common/custom_text_styles.dart';
// import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
// import 'package:ampify_admin_bloc/widgets/validators_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final _emailController = TextEditingController();
//     final _passwordController = TextEditingController();
//     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: SafeArea(
//         child: Container(
//           child: SizedBox.expand(
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Form(
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     // crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 10),
//                       Text(
//                         'Admin-Login',
//                         style: CustomTextStyles.screenHeading(),
//                       ),
//                       const SizedBox(height: 10),
//                       Column(
//                         children: [
//                           Center(
//                             child: Image.asset(
//                               'assets/images/signup.png',
//                               height: 300,
//                               width: 300,
//                             ),
//                           ),
//                         ],
//                       ),
//                       CustomTextFormField(
//                         controller: _emailController,
//                         labelText: 'Username',
//                         keyboardType: TextInputType.emailAddress,
//                         prefixicon: const Icon(Icons.text_fields_rounded),
//                         validator: Validators.validateEmail,
//                       ),
//                       const SizedBox(height: 20),
//                       BlocBuilder<AuthBloc, AuthState>(
//                         builder: (context, state) {
//                           bool isPasswordVisible = false;
//                           if (state is AuthPasswordVisibilityChanged) {
//                             isPasswordVisible = state.isPasswordVisible;
//                           }
//                           return CustomTextFormField(
//                             controller: _passwordController,
//                             labelText: 'Password',
//                             obscureText: !isPasswordVisible,
//                             prefixicon: const Icon(Icons.password_outlined),
//                             validator: Validators.validatePassword,
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 isPasswordVisible
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                               ),
//                               onPressed: () {
//                                 context.read<AuthBloc>().add(
//                                     TogglePasswordVisibility(
//                                         !isPasswordVisible));
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const ForgotPassword(),
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             'Forgot your password?',
//                             style: TextStyle(color: Color(0xFF31473A)),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       BlocConsumer<AuthBloc, AuthState>(
//                         listener: (context, state) {
//                           if (state is AuthSuccess) {
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => AdminDashboard(),
//                               ),
//                             );
//                           }
//                           if (state is AuthError) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text(state.message)),
//                             );
//                           }
//                         },
//                         builder: (context, state) {
//                           return CustomButton(
//                             label: 'Login',
//                             onTap: () {
//                               if (_formKey.currentState?.validate() ?? false) {
//                                 context.read<AuthBloc>().add(
//                                       LoginUserWithEmailAndPassword(
//                                         email: _emailController.text,
//                                         password: _passwordController.text,
//                                       ),
//                                     );
//                               }
//                             },
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

///************************************************************************************* */
///
import 'package:ampify_admin_bloc/authentication/bloc/auth_bloc.dart';
import 'package:ampify_admin_bloc/authentication/bloc/auth_state.dart';
// import 'package:ampify_admin_bloc/authentication/screens/forgot_password.dart';
import 'package:ampify_admin_bloc/common/app_colors.dart';
import 'package:ampify_admin_bloc/screens/admin_panel/admin_dashboard.dart';
import 'package:ampify_admin_bloc/widgets/custom_button.dart';
import 'package:ampify_admin_bloc/common/custom_text_styles.dart';
import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
import 'package:ampify_admin_bloc/widgets/validators_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColorLight,
      ),
      backgroundColor: AppColors.backgroundColorLight,
      body: Container(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Admin-Login',
                      style: CustomTextStyles.screenHeading(),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/signup.png',
                            height: 300,
                            width: 300,
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      controller: _emailController,
                      labelText: 'Username',
                      keyboardType: TextInputType.emailAddress,
                      prefixicon: const Icon(Icons.text_fields_rounded),
                      validator: Validators.validateEmail,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        bool isPasswordVisible = false;
                        if (state is AuthPasswordVisibilityChanged) {
                          isPasswordVisible = state.isPasswordVisible;
                        }
                        return CustomTextFormField(
                          controller: _passwordController,
                          labelText: 'Password',
                          obscureText: !isPasswordVisible,
                          prefixicon: const Icon(Icons.password_outlined),
                          validator: Validators.validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                  TogglePasswordVisibility(!isPasswordVisible));
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          // Show success SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login Successful!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          //Navigate to Dashboard
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminDashboard(),
                            ),
                          );
                        }
                        if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                            label: 'Login',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                if (_emailController.text ==
                                        'lijith006@gmail.com' &&
                                    _passwordController.text == 'admin123') {
                                  context.read<AuthBloc>().add(
                                        LoginUserWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        ),
                                      );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text('Invalid username or password'),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              }
                            }
                            // },
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
