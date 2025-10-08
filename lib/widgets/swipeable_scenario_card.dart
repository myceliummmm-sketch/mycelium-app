import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/p2p_scenario.dart';
import '../theme/app_theme.dart';

class SwipeableScenarioCard extends StatefulWidget {
  final P2PScenario scenario;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final bool isTop;

  const SwipeableScenarioCard({
    super.key,
    required this.scenario,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.isTop = false,
  });

  @override
  State<SwipeableScenarioCard> createState() => _SwipeableScenarioCardState();
}

class _SwipeableScenarioCardState extends State<SwipeableScenarioCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _dragOffset = Offset.zero;
  double _dragAngle = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
      _dragAngle = _dragOffset.dx / 1000;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });

    // Check if swiped far enough
    if (_dragOffset.dx.abs() > 120) {
      if (_dragOffset.dx > 0) {
        // Swiped right - like
        _swipeRight();
      } else {
        // Swiped left - skip
        _swipeLeft();
      }
    } else {
      // Return to center
      _resetPosition();
    }
  }

  void _swipeLeft() {
    final animation = Tween<Offset>(
      begin: _dragOffset,
      end: const Offset(-500, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    animation.addListener(() {
      setState(() {
        _dragOffset = animation.value;
        _dragAngle = _dragOffset.dx / 1000;
      });
    });

    _controller.forward().then((_) {
      _controller.reset();
      widget.onSwipeLeft?.call();
    });
  }

  void _swipeRight() {
    final animation = Tween<Offset>(
      begin: _dragOffset,
      end: const Offset(500, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    animation.addListener(() {
      setState(() {
        _dragOffset = animation.value;
        _dragAngle = _dragOffset.dx / 1000;
      });
    });

    _controller.forward().then((_) {
      _controller.reset();
      widget.onSwipeRight?.call();
    });
  }

  void _resetPosition() {
    final animation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    animation.addListener(() {
      setState(() {
        _dragOffset = animation.value;
        _dragAngle = _dragOffset.dx / 1000;
      });
    });

    _controller.forward().then((_) {
      _controller.reset();
    });
  }

  void swipeLeftProgrammatically() {
    _swipeLeft();
  }

  void swipeRightProgrammatically() {
    _swipeRight();
  }

  @override
  Widget build(BuildContext context) {
    final opacity = widget.isTop
        ? 1.0
        : (1.0 - (_dragOffset.dx.abs() / 500)).clamp(0.0, 1.0);

    final scale = widget.isTop ? 1.0 : 0.95;

    return GestureDetector(
      onPanStart: widget.isTop ? _onPanStart : null,
      onPanUpdate: widget.isTop ? _onPanUpdate : null,
      onPanEnd: widget.isTop ? _onPanEnd : null,
      child: Transform.translate(
        offset: widget.isTop ? _dragOffset : Offset.zero,
        child: Transform.rotate(
          angle: widget.isTop ? _dragAngle : 0,
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacity,
              child: Container(
                width: double.infinity,
                height: 420,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.cardBackground,
                      AppColors.cardBackground.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Category badge
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryPurple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primaryPurple.withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          _getCategoryName(widget.scenario.category),
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primaryPurple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    // Emoji and title
                    Column(
                      children: [
                        Text(
                          widget.scenario.emoji,
                          style: const TextStyle(fontSize: 80),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.scenario.title,
                          style: AppTextStyles.h1.copyWith(fontSize: 28),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.scenario.description,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),

                    // Swipe indicators
                    if (widget.isTop && _isDragging)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Opacity(
                            opacity: (-_dragOffset.dx / 120).clamp(0.0, 1.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                              child: const Text(
                                'ПРОПУСТИТЬ',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: (_dragOffset.dx / 120).clamp(0.0, 1.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.success,
                                  width: 2,
                                ),
                              ),
                              child: const Text(
                                'НРАВИТСЯ',
                                style: TextStyle(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getCategoryName(String category) {
    switch (category) {
      case 'career':
        return 'Карьера';
      case 'relationships':
        return 'Отношения';
      case 'conflict':
        return 'Конфликт';
      case 'emotional':
        return 'Эмоции';
      case 'social':
        return 'Социум';
      case 'cognitive':
        return 'Мышление';
      default:
        return category;
    }
  }
}
