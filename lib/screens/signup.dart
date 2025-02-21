import 'package:airbnb/screens/login.dart';
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
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        _errorText = "Please fill in all fields.";
      });
    } else {
      try {

        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        
        // User successfully created, navigate to login page
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
          } else {
            _errorText = e.message;
          }
        });
      } catch (e) {
        setState(() {
          _errorText = "Something went wrong. Please try again.";
        });
      }
    }
  }


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
