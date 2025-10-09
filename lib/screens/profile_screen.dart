import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/metaskill_detailed.dart';
import '../models/life_sphere.dart';
import '../widgets/life_wheel_chart.dart';
import '../widgets/profile_detail_modal.dart';
import '../widgets/metaskills_radar_16.dart';
import '../config/app_version.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

            // Compact mCode Card
            _buildMCodeCard(),

            // Tabs
            _buildTabs(),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(),
                  _buildSpheresTab(),
                  _buildSkillsTab(),
                ],
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMCodeCard() {
    return GestureDetector(
      onTap: () => ProfileDetailModal.show(context),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        child: Row(
        children: [
          // Compact icon
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
                  'Level 12 • Trust: 87',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          // Compact badges
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCompactBadge('D/I'),
              const SizedBox(width: 4),
              _buildCompactBadge('ENTJ'),
            ],
          ),
        ],
        ),
      ),
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

  Widget _buildMCodeButton(String text, VoidCallback onTap) {
    return Material(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
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
        ),
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
        unselectedLabelColor: Colors.white.withOpacity(0.6),
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Сферы'),
          Tab(text: 'Скилы'),
        ],
      ),
    );
  }

  // OVERVIEW TAB
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🎯 ЗАДАЧИ ЭТОЙ НЕДЕЛИ',
            style: AppTextStyles.h3.copyWith(color: AppColors.primaryPurple),
          ),
          const SizedBox(height: 16),
          _buildSimpleTaskCard('📝 Пройти тест', '✅ Тест: 45/100', true),
          const SizedBox(height: 12),
          _buildSimpleTaskCard('🤖 Прочитать AI анализ', '✅ AI прочитано', true),
          const SizedBox(height: 12),
          _buildSimpleTaskCard('🎮 P2P практика', '○ P2P: не начато', false),
        ],
      ),
    );
  }

  Widget _buildSimpleTaskCard(String title, String status, bool done) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppDecorations.cardBackground,
      child: Row(
        children: [
          Text(
            done ? '✅' : '○',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: AppTextStyles.caption.copyWith(
                    color: done ? AppColors.success : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBadge(String text, bool done) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: done
            ? const Color(0xFF22C55E).withOpacity(0.15)
            : const Color(0xFF6B7280).withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: done ? const Color(0xFF166534) : const Color(0xFF6B7280),
        ),
      ),
    );
  }

  // SPHERES TAB
  Widget _buildSpheresTab() {
    final lifeWheel = LifeWheelBalance.fromMockData();

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: AppDecorations.cardBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🎨 СФЕРЫ ЖИЗНИ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryPurple,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 24),

            // Life Wheel Chart
            Center(
              child: LifeWheelChart(balance: lifeWheel, size: 320),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Средний балл', '${lifeWheel.averageBalance.toInt()}'),
                _buildStatItem('Гармония', '${(lifeWheel.harmony * 100).toInt()}%'),
              ],
            ),

            const SizedBox(height: 32),
            const Text(
              '💪 ТРЕНИРОВАТЬ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFFF59E0B),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),
            _buildSphereCard(
              name: '💰 Карьера',
              score: 45,
              isWeak: true,
              problems: [
                {
                  'text': '❌ Не просишь повышение, хотя заслуживаешь',
                  'p2p': true,
                  'ai': true,
                  'test': false,
                },
                {
                  'text': '❌ Избегаешь обсуждения зарплаты',
                  'p2p': false,
                  'ai': false,
                  'test': false,
                },
              ],
            ),
            const SizedBox(height: 12),
            _buildSphereCard(
              name: '🗣️ Коммуникация',
              score: 52,
              isWeak: true,
              problems: [
                {
                  'text': '❌ Боишься публичных выступлений',
                  'p2p': false,
                  'ai': false,
                  'test': true,
                },
              ],
            ),
            const SizedBox(height: 12),
            _buildSphereCard(
              name: '🎯 Стратегия',
              score: 85,
              isWeak: false,
              problems: [
                {
                  'text': '✅ Видишь долгосрочные тренды рынка',
                  'p2p': true,
                  'ai': true,
                  'test': true,
                },
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSphereCard({
    required String name,
    required int score,
    required bool isWeak,
    required List<Map<String, dynamic>> problems,
  }) {
    return Column(
      children: problems.map((problem) {
        // Remove emoji from problem text if it exists
        String problemText = problem['text'] as String;
        problemText = problemText.replaceFirst(RegExp(r'^[❌✅]\s*'), '');

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: AppDecorations.cardBackground,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  // TODO: Mark as completed
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isWeak ? const Color(0xFFF59E0B) : AppColors.success,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: isWeak ? null : const Icon(Icons.check, size: 16, color: AppColors.success),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // TODO: Show problem details modal
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        problemText,
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$name • Балл: $score',
                        style: AppTextStyles.caption.copyWith(
                          color: isWeak ? const Color(0xFFF59E0B) : AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // SKILLS TAB
  Widget _buildSkillsTab() {
    final skills = MetaskillDetailed.getAll16Skills();
    final weakSkills = skills.where((s) => s.currentLevel < 60).take(3).toList();

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: AppDecorations.cardBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '⚡ 16 МЕТАСКИЛОВ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryPurple,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 24),

            // 16 Metaskills Radar
            Center(
              child: MetaskillsRadar16(
                skills: skills,
                size: 420,
                onSkillTap: (skill) {
                  // TODO: Open metaskill detail modal
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: AppColors.cardBackground,
                      title: Text(
                        '${skill.emoji} ${skill.title}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      content: Text(
                        skill.description,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Закрыть'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // Weak skills list
            const Text(
              '💪 ТРЕНИРОВАТЬ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFFF59E0B),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),

            ...weakSkills.map((skill) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: AppDecorations.cardBackground,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO: Mark as completed
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFF59E0B), width: 2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Show metaskill details modal
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${skill.emoji} ${skill.title}',
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Текущий балл: ${skill.currentLevel}',
                            style: AppTextStyles.caption.copyWith(
                              color: const Color(0xFFF59E0B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }


  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.h2.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }

  Widget _buildDomainLabel(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

}
