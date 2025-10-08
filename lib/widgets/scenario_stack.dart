import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/p2p_scenario.dart';
import 'swipeable_scenario_card.dart';

class ScenarioStack extends StatefulWidget {
  final List<P2PScenario> scenarios;
  final Function(P2PScenario)? onLike;
  final Function(P2PScenario)? onSkip;
  final VoidCallback? onStackEmpty;

  const ScenarioStack({
    super.key,
    required this.scenarios,
    this.onLike,
    this.onSkip,
    this.onStackEmpty,
  });

  @override
  State<ScenarioStack> createState() => _ScenarioStackState();
}

class _ScenarioStackState extends State<ScenarioStack> {
  final GlobalKey _topCardKey = GlobalKey();
  int _currentIndex = 0;
  List<P2PScenario> _scenarios = [];

  @override
  void initState() {
    super.initState();
    _scenarios = List.from(widget.scenarios);
  }

  void _handleSwipeLeft() {
    final scenario = _scenarios[_currentIndex];
    widget.onSkip?.call(scenario);

    setState(() {
      _currentIndex++;
      if (_currentIndex >= _scenarios.length) {
        widget.onStackEmpty?.call();
      }
    });
  }

  void _handleSwipeRight() {
    final scenario = _scenarios[_currentIndex];
    widget.onLike?.call(scenario);

    setState(() {
      _currentIndex++;
      if (_currentIndex >= _scenarios.length) {
        widget.onStackEmpty?.call();
      }
    });
  }

  void swipeLeft() {
    (_topCardKey.currentState as dynamic)?.swipeLeftProgrammatically();
  }

  void swipeRight() {
    (_topCardKey.currentState as dynamic)?.swipeRightProgrammatically();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex >= _scenarios.length) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '🎉',
              style: TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 20),
            const Text(
              'Все сценарии просмотрены!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Начните сессию с выбранными сценариями',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // Show next 2 cards behind
        for (int i = math.min(_currentIndex + 2, _scenarios.length - 1);
            i > _currentIndex;
            i--)
          Positioned(
            top: (i - _currentIndex) * 4.0,
            child: SwipeableScenarioCard(
              scenario: _scenarios[i],
              isTop: false,
            ),
          ),
        // Top card (swipeable)
        SwipeableScenarioCard(
          key: _topCardKey,
          scenario: _scenarios[_currentIndex],
          isTop: true,
          onSwipeLeft: _handleSwipeLeft,
          onSwipeRight: _handleSwipeRight,
        ),
      ],
    );
  }
}
