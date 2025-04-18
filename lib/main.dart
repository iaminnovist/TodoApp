import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todotask/features/auth/presentation/pages/login_page.dart';
import 'package:todotask/features/auth/presentation/pages/signup_page.dart';
import 'package:todotask/features/home/presentation/pages/home_page.dart';
import 'package:todotask/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:todotask/features/auth/presentation/providers/auth_provider.dart';
import 'package:todotask/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:todotask/features/home/presentation/providers/home_provider.dart';
import 'package:todotask/core/services/storage_service.dart';
import 'package:todotask/core/services/firebase_auth_service.dart';
import 'package:todotask/features/navigation/presentation/pages/main_navigation.dart';

import 'core/services/firebase_service.dart';
import 'features/splash/presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize StorageService
    final storageService = StorageService();
    await storageService.init();
    
    runApp(MyApp(storageService: storageService));
  } catch (e) {
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Error initializing Firebase',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => main(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final StorageService storageService;

  const MyApp({
    required this.storageService,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StorageService>(
          create: (_) => storageService,
        ),
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(
            context.read<FirebaseAuthService>(),
            context.read<StorageService>(),
          ),
        ),
        ChangeNotifierProvider<OnboardingProvider>(
          create: (context) => OnboardingProvider(
            storageService: context.read<StorageService>(),
          ),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(
            authProvider: context.read<AuthProvider>(),
            firebaseAuthService: context.read<FirebaseAuthService>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Todo Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD86628)),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/onboarding': (context) => const OnboardingPage(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
          '/main': (context) => const MainNavigation(),
        },
      ),
    );
  }
}
