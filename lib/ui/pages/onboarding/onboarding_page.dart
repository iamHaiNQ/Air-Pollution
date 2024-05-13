import 'package:airpollution/commons/app_text_styles.dart';
import 'package:airpollution/ui/pages/main/main_page.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                _buildPage(
                    imagePath: 'assets/images/img_onboarding1.png',
                    title: 'Breath Better',
                    description:
                        'Understand the air around you, wherever you go with the largest coverage of trusted data.',
                    screenWidth: screenWidth),
                _buildPage(
                    imagePath: 'assets/images/img_onboarding2.png',
                    title: 'Track Pollution',
                    description:
                        'Discover your personal exposure during your daily routine and take action to reduce it',
                    screenWidth: screenWidth),
                _buildPage(
                  imagePath: 'assets/images/img_onboarding3.png',
                  title: 'Controll Exposure',
                  description:
                      'During your daily routin,e discover your personal exposure and take action',
                  screenWidth: screenWidth,
                ),
              ],
            ),
            Positioned(
              top: 20.0,
              right: 20.0,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.transparent)),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff4B5563),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 167,
              top: 490,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                  if (_currentPage == 2) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fixedSize: const Size(311.0, 48.0),
                  padding: EdgeInsets.zero,
                  textStyle: const TextStyle(fontSize: 16.0),
                  elevation: 0,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF188EFF),
                        Color(0xFF53FEEF),
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                  ),
                  child: Container(
                    width: 311.0,
                    height: 48.0,
                    alignment: Alignment.center,
                    child: const Text(
                      'Get Started',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String imagePath,
    required String title,
    required String description,
    required double screenWidth,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 59),
          child: Image.asset(
            imagePath,
            width: screenWidth,
            height: screenWidth,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 60.0),
        Text(
          title,
          style: AppTextStyle.textOnboarding,
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyle.textOnboarding1,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      indicators.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 6.0,
      width: isActive ? 20.0 : 6.0,
      decoration: BoxDecoration(
        gradient: isActive
            ? const LinearGradient(
                colors: [
                  Color(0xFF50F0E1),
                  Color(0xFF329BFF),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        // Màu của indicator khi không active sẽ là màu mặc định của container
        color: !isActive ? Colors.grey : null,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
