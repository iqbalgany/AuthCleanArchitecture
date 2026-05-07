import 'package:auth_clean_architecture/core/di/get_it.dart';
import 'package:auth_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:auth_clean_architecture/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:auth_clean_architecture/features/auth/presentation/pages/login_page.dart';
import 'package:auth_clean_architecture/features/home/presentations/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());

  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>()..checkAuthStatus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return HomePage();
            }

            if (state is AuthLoading) {
              return Scaffold(
                body: Center(child: CupertinoActivityIndicator()),
              );
            }
            return LoginPage();
          },
        ),
      ),
    );
  }
}
