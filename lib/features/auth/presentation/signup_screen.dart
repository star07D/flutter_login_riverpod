import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/login_provider.dart';
import 'home_screen.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Icon(Icons.person_add_outlined, size: 72),
                const SizedBox(height: 24),

                /// EMAIL
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter email';
                    }
                    if (!value.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// PASSWORD
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Minimum 6 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                /// SIGNUP BUTTON (INSTANT NAVIGATION)
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomeScreen(),
                          ),
                        );


                        ref.read(loginProvider.notifier).signup(
                          email: _emailController.text.trim(),
                          password:
                          _passwordController.text.trim(),
                        );
                      }
                    },
                    child: const Text('Create Account'),
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
