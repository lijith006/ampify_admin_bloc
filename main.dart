// import 'package:ampify_admin_bloc/authentication/admin_auth_service/auth_service.dart';
// import 'package:ampify_admin_bloc/authentication/bloc/auth_bloc.dart';
// import 'package:ampify_admin_bloc/screens/splash_screen.dart';
// import 'package:ampify_admin_bloc/themes/cubit/theme_cubit.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:path_provider/path_provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");
//   await Firebase.initializeApp();

//   final storage = await HydratedStorage.build(
//     storageDirectory: await getApplicationDocumentsDirectory(),
//   );

//   HydratedBlocOverrides.runZoned(
//     () => runApp(const MyApp()),
//     storage: storage,
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<AuthBloc>(
//           create: (_) => AuthBloc(AdminAuthService()),
//         ),
//         BlocProvider<ThemeCubit>(create: (_) => ThemeCubit())
//       ],
//       child: BlocBuilder<ThemeCubit, ThemeData>(
//         builder: (context, theme) {
//           return MaterialApp(
//               debugShowCheckedModeBanner: false,
//               title: 'Ampify',
//               theme: theme,
//               home: const SplashScreen());
//         },
//       ),
//     );
//   }
// }
import 'package:ampify_admin_bloc/authentication/admin_auth_service/auth_service.dart';
import 'package:ampify_admin_bloc/authentication/bloc/auth_bloc.dart';
import 'package:ampify_admin_bloc/logic/banner/edit_banner/bloc/edit_banner_bloc.dart';
import 'package:ampify_admin_bloc/screens/splash_screen.dart';
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
        BlocProvider<EditBannerBloc>(
          create: (_) => EditBannerBloc(),
        ),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ampify',
          home: SplashScreen()),
    );
  }
}
