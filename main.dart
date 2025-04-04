// import 'package:ampify_admin_bloc/authentication/admin_auth_service/auth_service.dart';
// import 'package:ampify_admin_bloc/authentication/bloc/auth_bloc.dart';
// import 'package:ampify_admin_bloc/banner/edit_banner/edit_banner_bloc.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_bloc.dart';
// import 'package:ampify_admin_bloc/screens/splash_screen.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/admin_auth_service/auth_service.dart';
import 'authentication/bloc/auth_bloc.dart';
import 'banner/edit_banner/edit_banner_bloc.dart';
import 'firebase_options.dart';
import 'screens/order_details_screen/bloc/order_bloc.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");
//   await Firebase.initializeApp();

//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(AdminAuthService()),
        ),
        BlocProvider<EditBannerBloc>(
          create: (_) => EditBannerBloc(),
        ),
        BlocProvider<OrderBloc>(create: (context) => OrderBloc()),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ampify',
          home: SplashScreen()),
    );
  }
}
