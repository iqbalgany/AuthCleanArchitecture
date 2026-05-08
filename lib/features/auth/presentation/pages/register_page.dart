import 'package:auth_clean_architecture/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:auth_clean_architecture/features/auth/presentation/widgets/custom_button.dart';
import 'package:auth_clean_architecture/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();

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
                  'Register',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 30),

                CustomTextField(
                  hint: 'Full Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The full name field cannot be left blank';
                    }
                    if (value.length < 3) {
                      return 'The name must be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

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

                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthRegisterSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Registration successful. Please log in.',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    }
                    if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().register(
                          email.text.trim(),
                          password.text.trim(),
                          fullName.text.trim(),
                        );
                      }
                    },
                    text: 'Register',
                  ),
                ),
                SizedBox(height: 15),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Do you have an account? ',
                        style: TextStyle(
                          color: Colors.black26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Login',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
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
