import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/metaskill_detailed.dart';
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
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
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
                  _buildMoreTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMCodeCard() {
    return Container(
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
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: const Color(0xFF667EEA),
        indicatorWeight: 3,
        labelColor: const Color(0xFF667EEA),
        unselectedLabelColor: const Color(0xFF6B7280),
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Сферы'),
          Tab(text: 'Скилы'),
          Tab(text: 'More'),
        ],
      ),
    );
  }

  // OVERVIEW TAB
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🎯 ЗАДАЧИ ЭТОЙ НЕДЕЛИ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF667EEA),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),
            _buildTaskCard(
              number: 1,
              title: 'Попроси повышение или бонус',
              description: 'Ты избегаешь разговоров о деньгах. Составь аргументы о своей ценности и назначь встречу с руководителем.',
              testDone: true,
              testScore: '45/100',
              aiDone: true,
              p2pDone: false,
              nextStep: 'Следующий шаг: пройди P2P практику для прокачки',
            ),
            const SizedBox(height: 12),
            _buildTaskCard(
              number: 2,
              title: 'Публичное выступление на 5 минут',
              description: 'Запишись на митап или созвон команды. Подготовь короткий доклад о своём проекте и выступи перед коллегами.',
              testDone: false,
              aiDone: false,
              p2pDone: false,
              nextStep: 'Рекомендуем: начни с теста, чтобы понять свой уровень',
            ),
            const SizedBox(height: 12),
            _buildTaskCard(
              number: 3,
              title: 'Делегируй одну задачу полностью ✅',
              description: 'Выбери рутинную задачу, которую ты всегда делаешь сам. Передай её коллеге с чёткими инструкциями.',
              testDone: true,
              testScore: '73/100',
              aiDone: true,
              p2pDone: true,
              p2pScore: '92%',
              nextStep: '✅ Задача выполнена! Отличная работа!',
              completed: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard({
    required int number,
    required String title,
    required String description,
    required bool testDone,
    String? testScore,
    required bool aiDone,
    required bool p2pDone,
    String? p2pScore,
    required String nextStep,
    bool completed = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF7ED), Color(0xFFFFEDD5)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: const Border(
          left: BorderSide(color: Color(0xFFF59E0B), width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Task number
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFFF59E0B),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF92400E),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFFB45309),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),

          // Progress
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _buildProgressBadge(
                      testDone ? '✅ Тест: ${testScore ?? 'готово'}' : '○ Тест: не пройден',
                      testDone,
                    ),
                    _buildProgressBadge(
                      aiDone ? '✅ AI прочитано' : '○ AI: не прочитано',
                      aiDone,
                    ),
                    _buildProgressBadge(
                      p2pDone ? '✅ P2P: ${p2pScore ?? 'готово'}' : '○ P2P: не начато',
                      p2pDone,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '→ $nextStep',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: completed ? const Color(0xFF166534) : const Color(0xFF92400E),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Action buttons
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: completed ? const Color(0xFF22C55E) : const Color(0xFFF59E0B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    completed ? '✅ Архивировать' : '🎮 Начать P2P',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF92400E),
                    side: const BorderSide(color: Color(0xFFF59E0B), width: 2),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '🤖 AI',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
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
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🎨 СФЕРЫ ЖИЗНИ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF667EEA),
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
    final bgColors = isWeak
        ? [const Color(0xFFFEF2F2), const Color(0xFFFEE2E2)]
        : [const Color(0xFFF0FDF4), const Color(0xFFDCFCE7)];
    final borderColor = isWeak ? const Color(0xFFEF4444) : const Color(0xFF22C55E);
    final nameColor = isWeak ? const Color(0xFF991B1B) : const Color(0xFF166534);
    final scoreColor = isWeak ? const Color(0xFFDC2626) : const Color(0xFF16A34A);
    final textColor = isWeak ? const Color(0xFF991B1B) : const Color(0xFF166534);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: bgColors,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: BorderSide(color: borderColor, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: nameColor,
                ),
              ),
              Text(
                '$score',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: scoreColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Problems
          ...problems.asMap().entries.map((entry) {
            final index = entry.key;
            final problem = entry.value;
            final isLast = index == problems.length - 1;

            return Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : Border(
                        bottom: BorderSide(
                          color: Colors.black.withOpacity(0.05),
                          width: 1,
                        ),
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    problem['text'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _buildProgressBadge(
                        problem['p2p'] as bool ? '✅ P2P: 87%' : '○ P2P',
                        problem['p2p'] as bool,
                      ),
                      _buildProgressBadge(
                        problem['ai'] as bool ? '✅ AI' : '○ AI',
                        problem['ai'] as bool,
                      ),
                      _buildProgressBadge(
                        problem['test'] as bool ? '✅ Тест' : '○ Тест',
                        problem['test'] as bool,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: textColor,
                        side: BorderSide(color: borderColor, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        isWeak ? '🎯 Начать решать' : '🎮 Помоги другим',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // SKILLS TAB
  Widget _buildSkillsTab() {
    final skills = MetaskillDetailed.getAll16Skills();

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '⚡ КАРТА НАВЫКОВ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF667EEA),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 24),

            // Circular skills wheel
            _buildSkillsWheel(skills),

            const SizedBox(height: 32),

            // Skills to improve
            const Text(
              '⚠️ ТРЕБУЮТ ПРОКАЧКИ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF667EEA),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),

            ...skills
                .where((s) => s.currentLevel < 60)
                .take(2)
                .map((skill) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildSkillImproveCard(skill),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsWheel(List<MetaskillDetailed> skills) {
    return Center(
      child: SizedBox(
        width: 320,
        height: 320,
        child: Stack(
          children: [
            // Background circles
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFE0E7FF),
                  width: 2,
                ),
              ),
            ),
            // Skill points
            ...skills.take(12).toList().asMap().entries.map((entry) {
              final index = entry.key;
              final skill = entry.value;
              final angle = (index * 30) * math.pi / 180;
              final radius = 140.0;
              final x = 160 + radius * math.cos(angle - math.pi / 2) - 32;
              final y = 160 + radius * math.sin(angle - math.pi / 2) - 32;

              return Positioned(
                left: x,
                top: y,
                child: _buildSkillPoint(skill),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillPoint(MetaskillDetailed skill) {
    final level = skill.currentLevel;
    final color = level >= 75
        ? const Color(0xFF22C55E)
        : level >= 60
            ? const Color(0xFFF59E0B)
            : const Color(0xFFEF4444);
    final textColor = level >= 75
        ? const Color(0xFF166534)
        : level >= 60
            ? const Color(0xFF92400E)
            : const Color(0xFF991B1B);

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            skill.emoji,
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 2),
          Text(
            '$level',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillImproveCard(MetaskillDetailed skill) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFEF2F2), Color(0xFFFEE2E2)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: const Border(
          left: BorderSide(color: Color(0xFFEF4444), width: 4),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                skill.emoji,
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  skill.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF991B1B),
                  ),
                ),
              ),
              Text(
                '${skill.currentLevel}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFDC2626),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '❌ Требует развития',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF991B1B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _buildProgressBadge('○ P2P', false),
                    _buildProgressBadge('○ AI', false),
                    _buildProgressBadge('○ Тест', false),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF991B1B),
                      side: const BorderSide(color: Color(0xFFEF4444), width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      '📝 Пройти тест',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // MORE TAB
  Widget _buildMoreTab() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '⚙️ НАСТРОЙКИ',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF667EEA),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              'Настройки профиля, подписка, приватность',
              style: TextStyle(
                color: Color(0xFF6B7280),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
