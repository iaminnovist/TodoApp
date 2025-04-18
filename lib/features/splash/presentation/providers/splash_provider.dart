import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  void navigateToNextScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2)); // Splash screen duration
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }
} 