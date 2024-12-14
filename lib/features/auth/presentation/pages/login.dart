import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_bloc/features/auth/presentation/components/custom_text_field.dart';

import '../cubits/auth_bloc.dart';

class Login extends StatefulWidget {
  Function()? togglePage;
  Login({super.key, required this.togglePage});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      final authCubit = BlocProvider.of<AuthBloc>(context);
      await authCubit.login(email, password);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Login to your account to continue.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),
                // Email Field using CustomTextField
                CustomTextField(
                  labelText: 'Email',
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Password Field using CustomTextField
                CustomTextField(
                  labelText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onSuffixIconTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  obscureText: !_isPasswordVisible,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Forgot Password & Signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigate to Forgot Password
                      },
                      child: const Text('Forgot Password?'),
                    ),
                    TextButton(
                      onPressed: widget.togglePage,
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
