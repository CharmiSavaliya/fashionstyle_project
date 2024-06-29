import 'package:fashion_project/model/on_boarding_model.dart';
import 'package:fashion_project/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late OnBoardingModel onBoardingModel;
  @override
  void initState() {
    onBoardingModel = onBoardingData.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                onBoardingModel.image,
                height: 700,
              ),
            ),
            buildOnboardingPage(
              title: onBoardingModel.title,
              description: onBoardingModel.subTitle,
              pageIndex: onBoardingModel.index,
            ),
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  onBoardingModel = onBoardingData.last;
                  setState(() {});
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnboardingPage({
    required String title,
    required String description,
    required int pageIndex,
  }) {
    return Stack(
      children: [
        Positioned(
          bottom: 1,
          left: 1,
          right: 1,
          child: Container(
            height: 340,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${title.split(' ')[0]} ',
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: title.substring(title.indexOf(' ') + 1),
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    description,
                    style: const TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                buildNavigationButtons(pageIndex),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNavigationButtons(int pageIndex) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: (pageIndex != 0),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (onBoardingModel.index != 0) {
                    onBoardingModel = onBoardingData[onBoardingModel.index - 1];
                  }
                  setState(() {});
                },
              ),
            ),
          ),
          SmoothPageIndicator(
            controller: PageController(initialPage: onBoardingModel.index),
            count: 3,
            effect: const WormEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.brown,
              dotHeight: 12,
              dotWidth: 12,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.brown,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              onPressed: () {
                if (onBoardingModel.index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                }
                if (onBoardingModel.index != 2) {
                  onBoardingModel = onBoardingData[onBoardingModel.index + 1];
                }
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
