import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../theme/app_theme.dart';

class CelebrationConfetti extends StatefulWidget {
  final Widget child;
  final bool shouldCelebrate;

  const CelebrationConfetti({
    super.key,
    required this.child,
    this.shouldCelebrate = false,
  });

  @override
  State<CelebrationConfetti> createState() => _CelebrationConfettiState();
}

class _CelebrationConfettiState extends State<CelebrationConfetti> {
  late ConfettiController _confettiController;
  late ConfettiController _confettiController2;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _confettiController2 = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void didUpdateWidget(CelebrationConfetti oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldCelebrate && !oldWidget.shouldCelebrate) {
      _celebrate();
    }
  }

  void _celebrate() {
    _confettiController.play();
    _confettiController2.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _confettiController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        // Left side confetti
        Align(
          alignment: Alignment.topLeft,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 4,
            particleDrag: 0.05,
            emissionFrequency: 0.05,
            numberOfParticles: 20,
            gravity: 0.2,
            shouldLoop: false,
            colors: const [
              AppColors.primaryPurple,
              AppColors.primaryBlue,
              AppColors.success,
              AppColors.warning,
              Colors.pink,
              Colors.orange,
            ],
          ),
        ),
        // Right side confetti
        Align(
          alignment: Alignment.topRight,
          child: ConfettiWidget(
            confettiController: _confettiController2,
            blastDirection: 3 * pi / 4,
            particleDrag: 0.05,
            emissionFrequency: 0.05,
            numberOfParticles: 20,
            gravity: 0.2,
            shouldLoop: false,
            colors: const [
              AppColors.primaryPurple,
              AppColors.primaryBlue,
              AppColors.success,
              AppColors.warning,
              Colors.pink,
              Colors.orange,
            ],
          ),
        ),
      ],
    );
  }
}

// Button widget that triggers celebration
class CelebrationButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  const CelebrationButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  State<CelebrationButton> createState() => _CelebrationButtonState();
}

class _CelebrationButtonState extends State<CelebrationButton> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _handlePress() {
    _confettiController.play();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: _handlePress,
          icon: Icon(widget.icon),
          label: Text(widget.label),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: -pi / 2,
            particleDrag: 0.05,
            emissionFrequency: 0.1,
            numberOfParticles: 15,
            gravity: 0.3,
            shouldLoop: false,
            blastDirectionality: BlastDirectionality.explosive,
            colors: const [
              AppColors.primaryPurple,
              AppColors.primaryBlue,
              AppColors.success,
              AppColors.warning,
            ],
          ),
        ),
      ],
    );
  }
}
