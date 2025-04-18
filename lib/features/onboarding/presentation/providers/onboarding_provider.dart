import 'package:flutter/material.dart';
import 'package:todotask/core/services/storage_service.dart';

class OnboardingProvider extends ChangeNotifier {
  final StorageService _storageService;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isLoading = false;

  OnboardingProvider({
    required StorageService storageService,
  }) : _storageService = storageService;

  // Getters
  PageController get pageController => _pageController;
  int get currentPage => _currentPage;
  bool get isLoading => _isLoading;

  // Methods
  Future<bool> hasCompletedOnboarding() async {
    return await _storageService.getBool('onboarding_completed') ?? false;
  }

  Future<String> hasLoggedIn() async {
    return await _storageService.getString('logged_in') ?? "";
  }

  void nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void skip() {
    _completeOnboarding();
  }

  void onPageChanged(int page) {
    _currentPage = page;
    notifyListeners();
  }

  Future<void> _completeOnboarding() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _storageService.setBool('onboarding_completed', true);
      // Navigate to login page after completing onboarding
    } catch (e) {
      debugPrint('Error completing onboarding: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
} 