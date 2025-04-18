import 'package:todotask/core/constants/app_constants.dart';
import 'package:todotask/features/onboarding/data/models/onboarding_page_model.dart';

abstract class OnboardingLocalDataSource {
  List<OnboardingPageModel> getOnboardingPages();
  Future<void> setOnboardingComplete();
  Future<bool> isOnboardingComplete();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  @override
  List<OnboardingPageModel> getOnboardingPages() {
    return [
      const OnboardingPageModel(
        image: AppConstants.onboarding1,
        title: '🎯 Stay Organized & Focused',
        description: 'Easily create, manage, and prioritize your tasks to stay on top of your day.',
      ),
      const OnboardingPageModel(
        image: AppConstants.onboarding2,
        title: '⌛ Never Miss a Deadline',
        description: 'Set reminders and due dates to keep track of important tasks effortlessly.',
      ),
      const OnboardingPageModel(
        image: AppConstants.onboarding3,
        title: '✅ Boost Productivity',
        description: 'Break tasks into steps, track progress, and get more done with ease.',
      ),
    ];
  }

  @override
  Future<void> setOnboardingComplete() async {
    // Implement using shared preferences or other local storage
  }

  @override
  Future<bool> isOnboardingComplete() async {
    // Implement using shared preferences or other local storage
    return false;
  }
} 