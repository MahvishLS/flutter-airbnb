import 'package:airbnb/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:airbnb/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _handleSignUp() async {
    setState(() {
      _errorText = null;
    });

    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        _errorText = "Please fill in all fields.";
      });
      return;
    }

    try {
      print("Attempting to create user...");
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("User created: ${userCredential.user?.uid}");

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'createdAt': Timestamp.now(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'weak-password') {
          _errorText = "The password is too weak.";
        } else if (e.code == 'email-already-in-use') {
          _errorText = "The account already exists for that email.";
        } else if (e.code == 'invalid-email') {
          _errorText = "Invalid email format.";
        } else {
          _errorText = e.message;
        }
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        _errorText = "Something went wrong. Please try again.";
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                "assets/images/logo-airbnb.png",
                height: 70,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 80),
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
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add some spacing
            ],
          ),
        ),
      ),
    );
  }
}
