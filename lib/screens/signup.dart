import 'package:airbnb/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:airbnb/theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorText;

  // void _handleSignUp() {
  //   String name = _nameController.text.trim();
  //   String email = _emailController.text.trim();
  //   String password = _passwordController.text.trim();

  //   if (name.isEmpty || email.isEmpty || password.isEmpty) {
  //     setState(() {
  //       _errorText = "Please fill in all fields.";
  //     });
  //   } else {
  //     setState(() {
  //       _errorText = null; 
  //     });
     
  //     print('Name: $name');
  //     print('Email: $email');
  //     print('Password: $password');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo-airbnb.png",
              height: 70,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 100),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                labelStyle: myTheme.inputDecorationTheme.labelStyle,
                hintText: 'Enter your full name',
                hintStyle: myTheme.inputDecorationTheme.hintStyle,
                border: myTheme.inputDecorationTheme.border,
                focusedBorder:
                    Theme.of(context).inputDecorationTheme.focusedBorder,
              ),
            ),
            const SizedBox(height: 20),
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
                hintText: 'Enter your password',
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                ),
                child: Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
