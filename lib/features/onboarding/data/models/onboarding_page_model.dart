import 'package:todotask/features/onboarding/domain/entities/onboarding_page.dart';

class OnboardingPageModel extends OnboardingPageEntity {
  const OnboardingPageModel({
    required String image,
    required String title,
    required String description,
  }) : super(
          image: image,
          title: title,
          description: description,
        );

  factory OnboardingPageModel.fromJson(Map<String, dynamic> json) {
    return OnboardingPageModel(
      image: json['image'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'description': description,
    };
  }
} 