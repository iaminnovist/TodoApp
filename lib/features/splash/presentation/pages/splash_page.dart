import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todotask/features/auth/presentation/providers/auth_provider.dart';
import 'package:todotask/features/onboarding/presentation/providers/onboarding_provider.dart';

import '../../../../core/services/user_singlton.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final onboardingProvider =
        Provider.of<OnboardingProvider>(context, listen: false);

    final hasCompletedOnboarding =
        await onboardingProvider.hasCompletedOnboarding();
    final hasloggedIn = await onboardingProvider.hasLoggedIn();
    final isLoggedIn = authProvider.currentUser != null;

    if (!mounted) return;

    if (hasloggedIn != "" && hasloggedIn != null) {
      UserSession().userId = hasloggedIn;
      Navigator.pushReplacementNamed(context, '/main');
    } else if (!hasCompletedOnboarding) {
      Navigator.pushReplacementNamed(context, '/onboarding');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD86628),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.check_circle_outline,
                color: Color(0xFFD86628),
                size: 32,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'TO-DO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
