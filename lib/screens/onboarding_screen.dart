import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_navigation.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Добро пожаловать в Mycelium",
          body: "Платформа для развития метаскилов и личностного роста через тесты, AI фидбэк и P2P общение",
          image: _buildImage('🍄', AppGradients.primaryGradient),
          decoration: _getPageDecoration(),
        ),
        PageViewModel(
          title: "Проходите тесты личности",
          body: "MBTI, Big Five, Эннеаграмма и другие тесты помогут узнать себя лучше и развить 16 метаскилов",
          image: _buildImage('🧠', AppGradients.purpleGradient),
          decoration: _getPageDecoration(),
        ),
        PageViewModel(
          title: "P2P Рулетка",
          body: "Случайные видеозвонки с участниками сообщества для обмена опытом и практики навыков",
          image: _buildImage('🎲', AppGradients.blueGradient),
          decoration: _getPageDecoration(),
        ),
        PageViewModel(
          title: "AI Фидбэк",
          body: "Персональные рекомендации от AI на основе ваших тестов, звонков и активности в приложении",
          image: _buildImage('🤖', AppGradients.successGradient),
          decoration: _getPageDecoration(),
        ),
        PageViewModel(
          title: "Соревнуйтесь и развивайтесь",
          body: "Зарабатывайте MYC токены, повышайте уровень и следите за прогрессом в рейтингах",
          image: _buildImage('🏆', AppGradients.warningGradient),
          decoration: _getPageDecoration(),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skip: const Text(
        'Пропус­тить',
        style: TextStyle(
          color: AppColors.primaryPurple,
          fontWeight: FontWeight.w600,
        ),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: AppColors.primaryPurple,
      ),
      done: const Text(
        'Начать',
        style: TextStyle(
          color: AppColors.primaryPurple,
          fontWeight: FontWeight.w700,
        ),
      ),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: AppColors.primaryPurple,
        color: AppColors.textSecondary.withOpacity(0.3),
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      globalBackgroundColor: AppColors.background,
      curve: Curves.easeInOutCubic,
      animationDuration: 500,
    );
  }

  void _onIntroEnd(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const MainNavigator(),
      ),
    );
  }

  Widget _buildImage(String emoji, Gradient gradient) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          gradient: gradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPurple.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 100),
          ),
        ),
      ),
    );
  }

  PageDecoration _getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 16.0,
        color: AppColors.textSecondary,
        height: 1.5,
      ),
      imagePadding: EdgeInsets.only(top: 80),
      bodyPadding: EdgeInsets.all(24),
      pageColor: AppColors.background,
    );
  }
}
