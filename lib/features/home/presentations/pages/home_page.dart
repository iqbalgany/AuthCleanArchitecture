import 'package:auth_clean_architecture/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:auth_clean_architecture/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomButton(
              onPressed: () {
                context.read<AuthCubit>().logout();
              },
              text: 'Logout',
            ),
          ),
        ),
      ),
    );
  }
}
