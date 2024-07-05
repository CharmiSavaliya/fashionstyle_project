import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fashion_project/forgot_password_screen.dart';
import 'package:fashion_project/sign_up_screen.dart';
import 'package:fashion_project/bottomnavigationbar.dart'; 

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with credential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Check if user is already registered
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        // Navigate to additional registration steps if needed
        // Example: Navigator.pushNamed(context, '/additional_registration');
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigationbarScreen(),
          ),
        );
      }
    } catch (e) {
      // Handle errors here
      print("Error signing in with Google: $e");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login({required BuildContext context}) async {
    String email = emailController.text.trim();
    String password = passwordController.text;

    // Validate email and password
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Email and Password cannot be empty');
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      _showSnackBar('Enter a valid email address');
      return;
    }

    if (password.length < 8) {
      _showSnackBar('Password must be at least 8 characters long');
      return;
    }

    try {
      // Navigate to main screen after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigationbarScreen(),
        ),
      );
    } catch (e) {
      _showSnackBar('Invalid email or password');
      print("Error logging in: $e");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Hi! Welcome back, you've been missed",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 70),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email',
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Email Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Password',
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen(),
                  ),
                ),
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color(0xff704F38),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () => _login(context: context),
              child: Container(
                width: 365,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xff704F38),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(85),
                ),
                child: const Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "or sign in with",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 45),
            GestureDetector(
              onTap: signInWithGoogle,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: ClipOval(
                  child: Image.asset(
                    'assets/google.png',
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Color(0xff704F38),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
