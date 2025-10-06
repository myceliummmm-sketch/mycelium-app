import 'dart:math' as dart_math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class P2PScreen extends StatefulWidget {
  const P2PScreen({super.key});

  @override
  State<P2PScreen> createState() => _P2PScreenState();
}

class _P2PScreenState extends State<P2PScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, Color(0xFF1A1F3A)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header - online indicator
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: AppDecorations.glassCard,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      )
                          .animate(
                            onPlay: (controller) => controller.repeat(),
                          )
                          .fadeIn(duration: 1000.ms)
                          .fadeOut(duration: 1000.ms),
                      const SizedBox(width: 10),
                      const Text(
                        '247 человек онлайн',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Main P2P Button
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Rotating outer ring
                    RotationTransition(
                      turns: _rotationController,
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryPurple.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          children: List.generate(8, (index) {
                            final angle = (index * 45) * (3.14159 / 180);
                            return Positioned(
                              left: 125 +
                                  115 * cos(angle) -
                                  4, // 125 = radius, 115 = distance from center
                              top: 125 + 115 * sin(angle) - 4,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryPurple
                                      .withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),

                    // Pulsating button
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Navigate to chatroulette
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Запуск рулетки...'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: AppGradients.primaryGradient,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryPurple.withOpacity(0.6),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.casino,
                                color: Colors.white,
                                size: 64,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'START',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                'РУЛЕТКА',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        )
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .scale(
                              begin: const Offset(1.0, 1.0),
                              end: const Offset(1.15, 1.15),
                              duration: 2000.ms,
                              curve: Curves.easeInOut,
                            )
                            .then()
                            .scale(
                              begin: const Offset(1.15, 1.15),
                              end: const Offset(1.0, 1.0),
                              duration: 2000.ms,
                              curve: Curves.easeInOut,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Scheduled quiz card
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppDecorations.glassCard,
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          gradient: AppGradients.successGradient,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.event,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Запланированный квиз',
                              style: AppTextStyles.h3,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'с Максом в 15:00',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.textSecondary,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double cos(double angle) => dart_math.cos(angle);
  double sin(double angle) => dart_math.sin(angle);
}
