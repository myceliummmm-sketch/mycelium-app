import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../screens/home_screen.dart';
import '../screens/tests_screen.dart';
import '../screens/p2p_screen.dart';
import '../screens/ai_screen.dart';
import '../screens/leaderboard_screen.dart';
import '../screens/community_screen.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    TestsScreen(),
    P2PScreen(),
    AIScreen(),
    LeaderboardScreen(),
    CommunityScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildP2PButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.quiz, 'Tests', 1),
          const SizedBox(width: 80), // Space for P2P button
          _buildNavItem(Icons.psychology, 'AI', 3),
          _buildNavItem(Icons.groups, 'Community', 5),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.primaryPurple : AppColors.textSecondary,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.primaryPurple : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildP2PButton() {
    final isSelected = _selectedIndex == 2;
    return GestureDetector(
      onTapDown: (_) {
        // Scale down animation on tap
      },
      onTapUp: (_) {
        _onItemTapped(2);
      },
      child: Container(
        width: 70,
        height: 70,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          gradient: AppGradients.primaryGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPurple.withOpacity(0.6),
              blurRadius: 30,
              spreadRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(
          Icons.casino,
          color: Colors.white,
          size: isSelected ? 36 : 32,
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
    );
  }
}
