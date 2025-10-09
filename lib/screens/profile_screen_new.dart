import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../models/level_system.dart';
import '../models/metaskill_detailed.dart';
import '../models/life_sphere.dart';
import '../widgets/metaskills_radar_16.dart';
import '../widgets/metaskill_detail_modal.dart';
import '../widgets/life_wheel_chart.dart';
import '../config/app_version.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mock user data
    final user = User(
      id: 'mock-user-id',
      telegramId: 123456789,
      firstName: 'Габиль',
      username: 'gabil',
      mycTokens: 1250,
      streakDays: 12,
      level: 28,
      levelProgress: 0.65,
      xp: 580,
      trustScore: 87.5,
      stats: UserStats(
        testsCompleted: 12,
        p2pCalls: 8,
        achievements: 4,
      ),
    );

    final userLevel = UserLevel.fromXP(user.xp);
    final all16Skills = MetaskillDetailed.getAll16Skills();
    final lifeWheel = LifeWheelBalance.fromMockData();

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
              // Version badge (top-right)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(top: 8, right: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryPurple.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    AppVersion.displayVersion,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ),
              ),

              // Compact mCode Card (clickable to expand)
              _buildMCodeCard(user, userLevel),

              // Tabs
              _buildTabs(),

              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildOverviewTab(user),
                    _buildDomainsTab(lifeWheel),
                    _buildSkillsTab(all16Skills),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMCodeCard(User user, UserLevel userLevel) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        padding: EdgeInsets.all(_isExpanded ? 20 : 12),
        decoration: BoxDecoration(
          gradient: AppGradients.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPurple.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
        child: _isExpanded ? _buildExpandedCard(user, userLevel) : _buildCompactCard(user),
      ),
    );
  }

  Widget _buildCompactCard(User user) {
    return Row(
      children: [
        // Icon
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text('🔮', style: TextStyle(fontSize: 28)),
          ),
        ),
        const SizedBox(width: 12),
        // Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'СТРАТЕГ-ВИЗИОНЕР',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Level ${user.level} • Trust: ${user.trustScore.toInt()}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
        // Badges
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCompactBadge('D/I'),
            const SizedBox(width: 4),
            _buildCompactBadge('ENTJ'),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandedCard(User user, UserLevel userLevel) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('🔮', style: TextStyle(fontSize: 40)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'СТРАТЕГ-ВИЗИОНЕР',
                    style: AppTextStyles.h2.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Level ${user.level} • ${user.xp} XP • Trust: ${user.trustScore.toInt()}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // MYC Tokens & Streak
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('🍄', style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 8),
                    Text(
                      '${user.mycTokens} MYC',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Text(
                    '${user.streakDays}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Personality chips
        Row(
          children: [
            _buildPersonalityChip('DISC', 'D/I'),
            const SizedBox(width: 8),
            _buildPersonalityChip('MBTI', 'ENTJ'),
            const SizedBox(width: 8),
            _buildPersonalityChip('ENNEAGRAM', 'Type 3'),
          ],
        ),
        const SizedBox(height: 16),
        // Buttons
        Row(
          children: [
            Expanded(
              child: _buildMCodeButton('📤 Share'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildMCodeButton('🍄 ${user.mycTokens} MYC'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildMCodeButton('💎 Pro'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompactBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPersonalityChip(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMCodeButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.primaryPurple,
        indicatorWeight: 3,
        labelColor: AppColors.primaryPurple,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        tabs: const [
          Tab(text: 'OVERVIEW'),
          Tab(text: 'ДОМЕНЫ'),
          Tab(text: 'СКИЛЫ'),
        ],
      ),
    );
  }

  // OVERVIEW TAB
  Widget _buildOverviewTab(User user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Задания',
            style: AppTextStyles.h2,
          ).animate(delay: 100.ms).fadeIn(),

          const SizedBox(height: 12),

          _buildTaskCard(
            '✅ Пройти тест MBTI',
            'Завершено',
            isCompleted: true,
          ),
          _buildTaskCard(
            '🤖 Получить AI фидбэк',
            'Доступно',
            isCompleted: false,
          ),
          _buildTaskCard(
            '🎮 Запись на P2P сессию',
            'Рекомендуем',
            isCompleted: false,
            isRecommended: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(
    String title,
    String subtitle, {
    required bool isCompleted,
    bool isRecommended = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: AppDecorations.cardBackground,
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.success.withOpacity(0.2)
                  : isRecommended
                      ? AppColors.warning.withOpacity(0.2)
                      : AppColors.textSecondary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompleted ? Icons.check : Icons.circle_outlined,
              color: isCompleted
                  ? AppColors.success
                  : isRecommended
                      ? AppColors.warning
                      : AppColors.textSecondary,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: isCompleted
                      ? AppTextStyles.body.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        )
                      : AppTextStyles.body.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(delay: 250.ms).fadeIn().slideX(begin: -0.2, end: 0);
  }

  // DOMAINS TAB
  Widget _buildDomainsTab(LifeWheelBalance lifeWheel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Колесо баланса',
            style: AppTextStyles.h2,
          ).animate(delay: 500.ms).fadeIn(),

          const SizedBox(height: 16),

          Center(
            child: LifeWheelChart(balance: lifeWheel, size: 280),
          ).animate(delay: 550.ms).fadeIn().scale(begin: const Offset(0.9, 0.9)),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Средний балл',
                '${lifeWheel.averageBalance.toInt()}',
              ),
              _buildStatItem(
                'Гармония',
                '${(lifeWheel.harmony * 100).toInt()}%',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // SKILLS TAB
  Widget _buildSkillsTab(List<MetaskillDetailed> all16Skills) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '16 Метанавыков',
            style: AppTextStyles.h2,
          ).animate(delay: 600.ms).fadeIn(),

          const SizedBox(height: 16),

          Center(
            child: MetaskillsRadar16(
              skills: all16Skills,
              size: 340,
              onSkillTap: (skill) {
                MetaskillDetailModal.show(context, skill);
              },
            ),
          ).animate(delay: 650.ms).fadeIn().scale(begin: const Offset(0.9, 0.9)),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.h2.copyWith(fontSize: 22)),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}
