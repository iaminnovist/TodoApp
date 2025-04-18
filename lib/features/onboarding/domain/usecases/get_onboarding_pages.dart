import 'package:todotask/features/onboarding/domain/entities/onboarding_page.dart';
import 'package:todotask/features/onboarding/domain/repositories/onboarding_repository.dart';

class GetOnboardingPages {
  final OnboardingRepository repository;

  GetOnboardingPages(this.repository);

  List<OnboardingPageEntity> call() {
    return repository.getOnboardingPages();
  }
} 