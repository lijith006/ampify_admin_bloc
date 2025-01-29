// import 'package:ampify_admin_bloc/authentication/bloc/auth_bloc.dart';
// import 'package:ampify_admin_bloc/authentication/bloc/auth_state.dart';
// import 'package:ampify_admin_bloc/authentication/screens/login_screen.dart';
// import 'package:ampify_admin_bloc/screens/admin_dashboard.dart';
// import 'package:ampify_admin_bloc/widgets/custom_button.dart';
// import 'package:ampify_admin_bloc/widgets/custom_text_styles.dart';
// import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
// import 'package:ampify_admin_bloc/widgets/validators_widget.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _nameController.dispose();
//     _phoneNumberController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/images/background.jpg'),
//                 fit: BoxFit.cover),
//           ),
//           child: SizedBox.expand(
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Form(
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 40),
//                       Text('Admin-Signup',
//                           style: CustomTextStyles.screenHeading()),
//                       Column(
//                         children: [
//                           Center(
//                             child: Image.asset(
//                               'assets/images/signup00.png',
//                               height: 350,
//                               width: 350,
//                             ),
//                           ),
//                         ],
//                       ),
//                       CustomTextFormField(
//                           controller: _nameController,
//                           labelText: 'Name',
//                           suffixIcon: const Icon(Icons.text_fields_rounded),
//                           validator: Validators.validateUsername),
//                       const SizedBox(height: 20),
//                       CustomTextFormField(
//                           controller: _emailController,
//                           labelText: 'Email',
//                           keyboardType: TextInputType.emailAddress,
//                           suffixIcon: const Icon(Icons.email_outlined),
//                           validator: Validators.validateEmail),
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

//                       const SizedBox(height: 20),
//                       CustomTextFormField(
//                           controller: _phoneNumberController,
//                           labelText: 'Phone number',
//                           keyboardType: TextInputType.phone,
//                           suffixIcon: const Icon(Icons.phone_android),
//                           validator: Validators.validatePhone),
//                       const SizedBox(height: 15),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           const Text("Already have an account?"),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const LoginScreen(),
//                                 ),
//                               );
//                             },
//                             child: const Text(
//                               'Login',
//                               style: TextStyle(color: Colors.red),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       BlocListener<AuthBloc, AuthState>(
//                         listener: (context, state) {
//                           if (state is AuthLoading) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text('Signing up...')),
//                             );
//                           }
//                           if (state is AuthSuccess) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text('Signup Successful!')),
//                             );
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
//                         child: Center(
//                           child: CustomButton(
//                             label: 'SignUp',
//                             onTap: () {
//                               if (_formKey.currentState?.validate() ?? false) {
//                                 // ..--Trigger the sign-up event in the BLoC---------
//                                 context.read<AuthBloc>().add(
//                                       CreateUserWithEmailAndPassword(
//                                         email: _emailController.text,
//                                         password: _passwordController.text,
//                                         _nameController.text,
//                                         _phoneNumberController.text,
//                                       ),
//                                     );
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const Divider(thickness: 1),
//                       const SizedBox(height: 20),
//                       //const Center(child: Text('Or login with Google account')),
//                       const SizedBox(height: 20),
//                       BlocBuilder<AuthBloc, AuthState>(
//                         builder: (context, state) {
//                           if (state is AuthLoading) {
//                             return const Center(
//                               child: SpinKitWave(
//                                 color: Colors.blue,
//                                 size: 35.0,
//                               ),
//                             );
//                           }
//                           return Center(
//                             child: InkWell(
//                               onTap: () {
//                                 //context.read<AuthBloc>().add(LoginWithGoogle());
//                               },
//                               child: const SizedBox(
//                                 width: 50,
//                                 height: 50,
//                                 //child: Image.asset('assets/images/google.png'),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 20),
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
