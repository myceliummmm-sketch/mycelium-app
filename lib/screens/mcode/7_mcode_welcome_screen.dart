import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '8_spheres_assessment_screen.dart';

class MCodeWelcomeScreen extends StatelessWidget {
  const MCodeWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryPurple,
              AppColors.secondaryBlue,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                const SizedBox(height: 60),

                // Контент
                Column(
                  children: [
                    // Иконка mCode
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.qr_code_2_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                    ).animate()
                      .fadeIn(duration: 600.ms)
                      .scale(delay: 200.ms, duration: 600.ms),

                    const SizedBox(height: 32),

                    Text(
                      'Добро пожаловать в\nmCode',
                      style: AppTextStyles.h1.copyWith(
                        fontSize: 32,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ).animate()
                      .fadeIn(delay: 400.ms, duration: 600.ms)
                      .slideY(begin: 0.3, end: 0, delay: 400.ms, duration: 600.ms),

                    const SizedBox(height: 16),

                    Text(
                      'Твой персональный код развития',
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ).animate()
                      .fadeIn(delay: 600.ms, duration: 600.ms)
                      .slideY(begin: 0.3, end: 0, delay: 600.ms, duration: 600.ms),
                  ],
                ),

                const SizedBox(height: 60),

                // Фичи
                Column(
                  children: [
                    _FeatureItem(
                      icon: Icons.hub_outlined,
                      title: '8 сфер жизни',
                      description: 'Развивай все аспекты одновременно',
                    ).animate()
                      .fadeIn(delay: 800.ms, duration: 400.ms)
                      .slideX(begin: -0.2, end: 0, delay: 800.ms, duration: 400.ms),

                    const SizedBox(height: 16),

                    _FeatureItem(
                      icon: Icons.auto_awesome,
                      title: 'Система уровней',
                      description: 'Получай XP и открывай новые сферы',
                    ).animate()
                      .fadeIn(delay: 1000.ms, duration: 400.ms)
                      .slideX(begin: -0.2, end: 0, delay: 1000.ms, duration: 400.ms),

                    const SizedBox(height: 16),

                    _FeatureItem(
                      icon: Icons.people_outline,
                      title: 'P2P сообщество',
                      description: 'Открывается на 5 уровне',
                    ).animate()
                      .fadeIn(delay: 1200.ms, duration: 400.ms)
                      .slideX(begin: -0.2, end: 0, delay: 1200.ms, duration: 400.ms),
                  ],
                ),

                const SizedBox(height: 60),

                // Кнопка
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SpheresAssessmentScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primaryPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Начать',
                          style: AppTextStyles.h3.copyWith(
                            color: AppColors.primaryPurple,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ).animate()
                      .fadeIn(delay: 1400.ms, duration: 400.ms)
                      .slideY(begin: 0.3, end: 0, delay: 1400.ms, duration: 400.ms),

                    const SizedBox(height: 16),

                    Text(
                      'Последний шаг • 2 минуты',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white60,
                      ),
                    ).animate()
                      .fadeIn(delay: 1600.ms, duration: 400.ms),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.h3.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
