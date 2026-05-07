import 'package:auth_clean_architecture/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:auth_clean_architecture/features/auth/presentation/pages/register_page.dart';
import 'package:auth_clean_architecture/features/auth/presentation/widgets/custom_button.dart';
import 'package:auth_clean_architecture/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 30),

                CustomTextField(
                  hint: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The email field cannot be left blank';
                    }
                    // Regex standar untuk validasi email
                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(value)) {
                      return 'Invalid email format';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                CustomTextField(
                  hint: 'Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The password cannot be left blank';
                    }
                    if (value.length < 6) {
                      return 'The password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),

                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().login(
                        email.text.trim(),
                        password.text.trim(),
                      );
                    }
                  },
                  text: 'Login',
                ),
                SizedBox(height: 15),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.black26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Register',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                        style: TextStyle(
                          color: Colors.indigoAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
