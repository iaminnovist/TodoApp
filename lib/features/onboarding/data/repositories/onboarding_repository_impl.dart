import 'package:todotask/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:todotask/features/onboarding/domain/entities/onboarding_page.dart';
import 'package:todotask/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl(this.localDataSource);

  @override
  List<OnboardingPageEntity> getOnboardingPages() {
    return localDataSource.getOnboardingPages();
  }

  @override
  Future<void> setOnboardingComplete() async {
    await localDataSource.setOnboardingComplete();
  }

  @override
  Future<bool> isOnboardingComplete() async {
    return await localDataSource.isOnboardingComplete();
  }
} 