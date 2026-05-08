import 'dart:developer';

import 'package:auth_clean_architecture/core/di/get_it.dart';
import 'package:auth_clean_architecture/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:auth_clean_architecture/features/auth/presentation/pages/login_page.dart';
import 'package:auth_clean_architecture/features/home/presentations/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          buildWhen: (previous, current) {
            return current is AuthAuthenticated ||
                current is AuthRegisterSuccess ||
                current is AuthUnauthenticated ||
                current is AuthInitial;
          },
          builder: (context, state) {
            log("State saat ini di UI: $state");
            if (state is AuthAuthenticated) {
              if (state.user.email.isEmpty) {
                return LoginPage();
              }
              return HomePage();
            }

            if (state is AuthLoading || state is AuthInitial) {
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
