import 'package:ampify_admin_bloc/authentication/admin_auth_service/auth_service.dart';
import 'package:ampify_admin_bloc/authentication/bloc/auth_bloc.dart';
import 'package:ampify_admin_bloc/screens/products/add_product.dart';
// import 'package:ampify_admin_bloc/screens/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(AdminAuthService()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ampify',
        home: AddProduct(),
      ),
    );
  }
}
