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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skills = MetaskillDetailed.getAll16Skills();
    final weakSkills = skills.where((s) => s.currentLevel < 60).toList();

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

              // mCode Card
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppGradients.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryPurple.withOpacity(0.35),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
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
                              const Text(
                                'Level 12 • 3,450 XP • Trust: 87',
                                style: TextStyle(
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
                          child: _buildMcodeButton('📤 Share'),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildMcodeButton('🍄 245 MYC'),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildMcodeButton('💎 Pro'),
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: -0.1, end: 0),

              // Tabs
              Container(
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
              ),

              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildOverviewTab(),
                    _buildDomainsTab(),
                    _buildSkillsTab(skills, weakSkills),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalityChip(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
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
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMcodeButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🎯 ЗАДАЧИ ЭТОЙ НЕДЕЛИ',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primaryPurple,
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          _buildTaskCard(
            number: 1,
            title: 'Попроси повышение или бонус',
            desc: 'Ты избегаешь разговоров о деньгах. Составь аргументы о своей ценности.',
            testDone: true,
            aiDone: true,
            p2pDone: false,
            testScore: 45,
          ),
          const SizedBox(height: 12),
          _buildTaskCard(
            number: 2,
            title: 'Публичное выступление на 5 минут',
            desc: 'Запишись на митап или созвон команды. Подготовь короткий доклад.',
            testDone: false,
            aiDone: false,
            p2pDone: false,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard({
    required int number,
    required String title,
    required String desc,
    required bool testDone,
    required bool aiDone,
    required bool p2pDone,
    int? testScore,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.warning.withOpacity(0.15),
            AppColors.warning.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: BorderSide(
            color: AppColors.warning,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.warning,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$number',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.8),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildProgressBadge(
                      testDone ? '✅ Тест: $testScore/100' : '○ Тест',
                      testDone,
                    ),
                    const SizedBox(width: 12),
                    _buildProgressBadge(
                      aiDone ? '✅ AI' : '○ AI',
                      aiDone,
                    ),
                    const SizedBox(width: 12),
                    _buildProgressBadge(
                      p2pDone ? '✅ P2P' : '○ P2P',
                      p2pDone,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '→ Следующий шаг: ${!p2pDone ? "пройди P2P практику" : !aiDone ? "прочитай AI разбор" : "пройди тест"}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.warning,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '🎮 Начать P2P',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.warning, width: 2),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '🤖 AI',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
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
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: done ? AppColors.success : AppColors.textSecondary,
      ),
    );
  }

  Widget _buildDomainsTab() {
    final domains = [
      {
        'name': '💰 Карьера',
        'score': 45,
        'isWeak': true,
        'problems': [
          'Не просишь повышение',
          'Избегаешь обсуждения зарплаты',
        ],
      },
      {
        'name': '🗣️ Коммуникация',
        'score': 52,
        'isWeak': true,
        'problems': [
          'Боишься публичных выступлений',
        ],
      },
      {
        'name': '🎯 Стратегия',
        'score': 85,
        'isWeak': false,
        'problems': [
          'Видишь долгосрочные тренды рынка',
        ],
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: domains.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final domain = domains[index];
        final isWeak = domain['isWeak'] as bool;
        final score = domain['score'] as int;
        final name = domain['name'] as String;
        final problems = domain['problems'] as List<String>;

        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isWeak
                  ? [
                      Colors.red.withOpacity(0.1),
                      Colors.red.withOpacity(0.05),
                    ]
                  : [
                      AppColors.success.withOpacity(0.1),
                      AppColors.success.withOpacity(0.05),
                    ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border(
              left: BorderSide(
                color: isWeak ? Colors.red : AppColors.success,
                width: 4,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: isWeak ? Colors.red.shade300 : AppColors.success,
                    ),
                  ),
                  Text(
                    '$score',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: isWeak ? Colors.red : AppColors.success,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...problems.map((problem) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${isWeak ? "❌" : "✅"} $problem',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: isWeak ? Colors.red : AppColors.success,
                                width: 2,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              isWeak ? '🎯 Начать решать' : '🎮 Помоги другим',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkillsTab(List<MetaskillDetailed> skills, List<MetaskillDetailed> weakSkills) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '⚡ КАРТА НАВЫКОВ',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primaryPurple,
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 24),
          // Radar Chart
          SizedBox(
            height: 320,
            child: CustomPaint(
              painter: _SkillsWheelPainter(skills),
              size: const Size(320, 320),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            '⚠️ ТРЕБУЮТ ПРОКАЧКИ',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primaryPurple,
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          ...weakSkills.map((skill) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.withOpacity(0.1),
                      Colors.red.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border(
                    left: BorderSide(
                      color: Colors.red,
                      width: 4,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(skill.emoji, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        skill.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      '${skill.currentLevel}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _SkillsWheelPainter extends CustomPainter {
  final List<MetaskillDetailed> skills;

  _SkillsWheelPainter(this.skills);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 40;

    // Draw grid circles
    final gridPaint = Paint()
      ..color = AppColors.primaryBlue.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(center, radius * i / 4, gridPaint);
    }

    // Draw axes
    final axisPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1;

    for (int i = 0; i < skills.length; i++) {
      final angle = (i * 2 * math.pi / skills.length) - math.pi / 2;
      final end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(center, end, axisPaint);
    }

    // Draw skill points
    for (int i = 0; i < skills.length; i++) {
      final skill = skills[i];
      final angle = (i * 2 * math.pi / skills.length) - math.pi / 2;
      final distance = radius * (skill.currentLevel / 100);
      final pos = Offset(
        center.dx + distance * math.cos(angle),
        center.dy + distance * math.sin(angle),
      );

      // Skill point
      final pointPaint = Paint()
        ..color = skill.currentLevel >= 70
            ? AppColors.success
            : skill.currentLevel >= 50
                ? AppColors.warning
                : Colors.red
        ..style = PaintingStyle.fill;

      canvas.drawCircle(pos, 6, pointPaint);

      // Emoji label
      final textPainter = TextPainter(
        text: TextSpan(
          text: skill.emoji,
          style: const TextStyle(fontSize: 20),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final labelDistance = radius + 20;
      final labelPos = Offset(
        center.dx + labelDistance * math.cos(angle) - textPainter.width / 2,
        center.dy + labelDistance * math.sin(angle) - textPainter.height / 2,
      );

      textPainter.paint(canvas, labelPos);
    }
  }

  @override
  bool shouldRepaint(_SkillsWheelPainter oldDelegate) => false;
}
