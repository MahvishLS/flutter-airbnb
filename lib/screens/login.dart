import 'package:airbnb/screens/signup.dart';
import 'package:airbnb/widgets/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:airbnb/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorText;

  Future<void> _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
    } catch (e) {

      setState(() {
        _errorText = "Invalid email or password. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 180),
              Center(
                child: Image.asset(
                  "assets/images/logo-airbnb.png",
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 60),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: myTheme.inputDecorationTheme.labelStyle,
                  hintText: 'Enter your email',
                  hintStyle: myTheme.inputDecorationTheme.hintStyle,
                  border: myTheme.inputDecorationTheme.border,
                  focusedBorder:
                      Theme.of(context).inputDecorationTheme.focusedBorder,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: myTheme.inputDecorationTheme.labelStyle,
                  hintText: 'Password',
                  hintStyle: myTheme.inputDecorationTheme.hintStyle,
                  border: myTheme.inputDecorationTheme.border,
                  focusedBorder:
                      Theme.of(context).inputDecorationTheme.focusedBorder,
                ),
                obscureText: true,
              ),
              if (_errorText != null) ...[
                const SizedBox(height: 10),
                Text(_errorText!, style: TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  child: Text(
                    'Signup',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: primaryColor,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
