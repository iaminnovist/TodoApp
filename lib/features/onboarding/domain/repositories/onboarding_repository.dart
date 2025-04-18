import 'package:todotask/features/onboarding/domain/entities/onboarding_page.dart';

abstract class OnboardingRepository {
  List<OnboardingPageEntity> getOnboardingPages();
  Future<void> setOnboardingComplete();
  Future<bool> isOnboardingComplete();
} 