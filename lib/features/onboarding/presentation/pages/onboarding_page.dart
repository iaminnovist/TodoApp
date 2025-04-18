import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todotask/core/constants/app_constants.dart';
import 'package:todotask/features/onboarding/presentation/providers/onboarding_provider.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingProvider = Provider.of<OnboardingProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: onboardingProvider.pageController,
            onPageChanged: onboardingProvider.onPageChanged,
            children: [
              _buildOnboardingPage(
                context,
                '🎯 Stay Organized & Focused',
                'Easily create, manage, and prioritize your tasks to stay on top of your day.',
                AppConstants.onboarding1,
              ),
              _buildOnboardingPage(
                context,
                '⌛ Never Miss a Deadline',
                'Set reminders and due dates to keep track of important tasks effortlessly.',
                AppConstants.onboarding2,
              ),
              _buildOnboardingPage(
                context,
                '✅ Boost Productivity',
                'Break tasks into steps, track progress, and get more done with ease.',
                AppConstants.onboarding3,
              ),
            ],
          ),
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: onboardingProvider.currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: onboardingProvider.currentPage == index
                            ? const Color(0xFFD86628)
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        if (onboardingProvider.currentPage == 2) {
                          Navigator.pushReplacementNamed(context, '/login');
                        } else {
                          onboardingProvider.nextPage();
                        }
                      },
                      child: Container(
                        width: 60,  // Diameter
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFFEB5E00),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(
    BuildContext context,
    String title,
    String description,
    String imagePath,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
      child: Column(
        children: [
          const SizedBox(height: 48),
          Image.asset(
            imagePath,
            height: 280,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 48),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D1517),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}