import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set status bar to transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyceliumApp());
}

class MyceliumApp extends StatelessWidget {
  const MyceliumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mycelium',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      // Show onboarding on first launch (can add SharedPreferences check later)
      home: const OnboardingScreen(),
    );
  }
}
