import 'package:fashion_project/onboarding_screen.dart';
import 'package:fashion_project/sign_in_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 180,
                  height: 450,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(85),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/ovel.jpeg'),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 170,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(85),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/round2.jpeg'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const CircleAvatar(
                      radius: 90,
                      backgroundImage: AssetImage('assets/round1.jpeg'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '   The',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        TextSpan(
                          text: ' Fashion App',
                          style: TextStyle(color: Color(0xff704F38), fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        TextSpan(
                          text: ' That Makes you look your Best',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  '     Lorem ipsum dolor sit amet, consectetur \nadipiscing elit, sed do eiumode tempor incididunt',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OnboardingScreen(),
                ),
              ),
              child: Container(
                width: 370,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xff704F38),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(85),
                ),
                child: const Center(
                  child: Text(
                    "Let's Get Started",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInScreen(),
                ),
              ),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    TextSpan(
                      text: ' ',
                    ),
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                        color: Color(0xff704F38),
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
