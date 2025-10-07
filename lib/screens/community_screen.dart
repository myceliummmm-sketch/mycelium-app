import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';
import '../config/app_version.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  'Комьюнити',
                  style: AppTextStyles.h1,
                ).animate().fadeIn().slideX(begin: -0.2, end: 0),

                const SizedBox(height: 8),

                Text(
                  'Растим мицелий вместе',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primaryPurple,
                  ),
                ).animate(delay: 100.ms).fadeIn(),

                const SizedBox(height: 24),

                // Your Mycelium card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppDecorations.gradientCard(
                    AppGradients.primaryGradient,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Ваш мицелий',
                            style: AppTextStyles.h2,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '7/8',
                              style: AppTextStyles.body,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'друзей уже в мицелии — вы растете!',
                        style: AppTextStyles.body,
                      ),
                      const SizedBox(height: 16),
                      // Friend avatars
                      Row(
                        children: [
                          _buildAvatar('assets/avatar1.png', true),
                          _buildAvatar('assets/avatar2.png', true),
                          _buildAvatar('assets/avatar3.png', true),
                          Container(
                            width: 36,
                            height: 36,
                            margin: const EdgeInsets.only(left: -8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryPurple,
                                width: 2,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                '+3',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate(delay: 150.ms).fadeIn().slideY(begin: 0.2, end: 0),

                const SizedBox(height: 20),

                // Mycelium Week - MAIN FEATURE
                const Text(
                  'Mycelium Week 🎯',
                  style: AppTextStyles.h1,
                ).animate(delay: 200.ms).fadeIn(),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: AppGradients.purpleGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryPurple.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Text('🎙️', style: TextStyle(fontSize: 32)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Еженедельный созвон',
                                  style: AppTextStyles.h2.copyWith(fontSize: 20),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'С основателем проекта',
                                  style: AppTextStyles.body.copyWith(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Каждую пятницу, 18:00 МСК',
                                  style: AppTextStyles.body.copyWith(fontSize: 15),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.people,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '23 участника уже записались',
                                  style: AppTextStyles.body.copyWith(fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.warning,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('🪙', style: TextStyle(fontSize: 24)),
                            const SizedBox(width: 10),
                            Text(
                              'Стоимость: 50 MYC',
                              style: AppTextStyles.h3.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Buy ticket
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Купить билет 🎫',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryPurple,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: 250.ms).fadeIn().scale(begin: const Offset(0.95, 0.95)),

                const SizedBox(height: 24),

                // Compact sections row
                Row(
                  children: [
                    // World Map - Compact
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _showWorldMap(context);
                        },
                        child: Container(
                          height: 120,
                          padding: const EdgeInsets.all(16),
                          decoration: AppDecorations.gradientCard(
                            AppGradients.blueGradient,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('🗺️', style: TextStyle(fontSize: 32)),
                              const SizedBox(height: 8),
                              Text(
                                'Карта',
                                style: AppTextStyles.body.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate(delay: 300.ms).fadeIn().scale(begin: const Offset(0.9, 0.9)),
                    ),
                    const SizedBox(width: 12),
                    // Invite Friends - Compact
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _showInviteFriends(context);
                        },
                        child: Container(
                          height: 120,
                          padding: const EdgeInsets.all(16),
                          decoration: AppDecorations.gradientCard(
                            AppGradients.successGradient,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('🤝', style: TextStyle(fontSize: 32)),
                              const SizedBox(height: 8),
                              Text(
                                'Пригласить',
                                style: AppTextStyles.body.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate(delay: 350.ms).fadeIn().scale(begin: const Offset(0.9, 0.9)),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Version display
                Center(
                  child: Text(
                    AppVersion.displayVersion,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ).animate(delay: 400.ms).fadeIn(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(String path, bool hasImage) {
    return Container(
      width: 36,
      height: 36,
      margin: const EdgeInsets.only(left: -8),
      decoration: BoxDecoration(
        color: AppColors.primaryPurple.withOpacity(0.3),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primaryPurple,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          hasImage ? '👤' : '?',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  void _showWorldMap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1F3A), AppColors.background],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('🗺️', style: TextStyle(fontSize: 40)),
                        const SizedBox(width: 16),
                        Text(
                          'Карта резидентов',
                          style: AppTextStyles.h1,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Mock world map with pins
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primaryBlue.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Mock pins with TG user avatars
                          _buildMapPin(30, 40, '👤', 'Анна К.', 'Москва'),
                          _buildMapPin(60, 30, '👨', 'Дмитрий С.', 'Питер'),
                          _buildMapPin(45, 55, '👩', 'Мария П.', 'Казань'),
                          _buildMapPin(70, 45, '🧑', 'Алексей В.', 'Екб'),
                          _buildMapPin(25, 65, '👨‍🦱', 'Иван М.', 'Сочи'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Stats
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: AppDecorations.cardBackground,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStat('47', 'Стран'),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white.withOpacity(0.1),
                              ),
                              _buildStat('247', 'Участников'),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white.withOpacity(0.1),
                              ),
                              _buildStat('12', 'Онлайн'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Ближайшие резиденты',
                      style: AppTextStyles.h3,
                    ),

                    const SizedBox(height: 12),

                    ..._buildNearbyUsers(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn().slideY(begin: 0.1, end: 0),
    );
  }

  void _showInviteFriends(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1F3A), AppColors.background],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('🤝', style: TextStyle(fontSize: 40)),
                        const SizedBox(width: 16),
                        Text(
                          'Пригласить друзей',
                          style: AppTextStyles.h1,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: AppDecorations.cardBackground,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Растите свой мицелий',
                            style: AppTextStyles.h3,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Приглашайте друзей и получайте награды. Каждый приглашенный друг повышает ваш Trust Score и открывает новые возможности.',
                            style: AppTextStyles.body,
                          ),
                          const SizedBox(height: 20),
                          // Mycelium network visualization
                          Center(
                            child: CustomPaint(
                              size: const Size(200, 180),
                              painter: _MyceliumNetworkPainter(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Награды за приглашения',
                      style: AppTextStyles.h3,
                    ),

                    const SizedBox(height: 12),

                    _buildRewardItem('1 друг', 'Respect +5', 5, isCompleted: true),
                    _buildRewardItem('3 друга', 'Trust Badge', 15, isCompleted: true),
                    _buildRewardItem(
                      '5 друзей',
                      'Приватный канал',
                      30,
                      isLocked: true,
                    ),
                    _buildRewardItem(
                      '10 друзей',
                      'PRO статус (1 месяц)',
                      100,
                      isLocked: true,
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Share invite link
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Поделиться ссылкой 🔗',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn().slideY(begin: 0.1, end: 0),
    );
  }

  Widget _buildMapPin(double left, double top, String emoji, String name, String city) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: AppGradients.primaryGradient,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 20)),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.h2.copyWith(
            fontSize: 28,
            color: AppColors.primaryPurple,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }

  List<Widget> _buildNearbyUsers() {
    final mockUsers = [
      {'name': 'Анна К.', 'city': 'Москва', 'distance': '2 км', 'emoji': '👤'},
      {'name': 'Дмитрий С.', 'city': 'Москва', 'distance': '5 км', 'emoji': '👨'},
      {'name': 'Мария П.', 'city': 'Москва', 'distance': '12 км', 'emoji': '👩'},
    ];

    return mockUsers.map((user) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: AppDecorations.cardBackground,
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: AppGradients.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  user['emoji']!,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user['name']!,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user['city']!,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            Text(
              user['distance']!,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildRewardItem(String milestone, String title, int mycAmount,
      {bool isLocked = false, bool isCompleted = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: isCompleted && !isLocked
            ? LinearGradient(
                colors: [
                  AppColors.success.withOpacity(0.2),
                  AppColors.success.withOpacity(0.1),
                ],
              )
            : null,
        color: isLocked ? Colors.white.withOpacity(0.05) : null,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isLocked
              ? Colors.white.withOpacity(0.1)
              : isCompleted
                  ? AppColors.success.withOpacity(0.5)
                  : Colors.white.withOpacity(0.1),
          width: isCompleted ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: isCompleted && !isLocked
                  ? LinearGradient(
                      colors: [
                        AppColors.success,
                        AppColors.success.withOpacity(0.7),
                      ],
                    )
                  : null,
              color: isLocked ? Colors.white.withOpacity(0.1) : null,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                isLocked ? '🔒' : '✓',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  milestone,
                  style: AppTextStyles.caption.copyWith(
                    color: isLocked
                        ? AppColors.textSecondary
                        : isCompleted
                            ? AppColors.success
                            : AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    color: isLocked
                        ? AppColors.textSecondary
                        : Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: AppGradients.warningGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Text('🪙', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 4),
                Text(
                  '+$mycAmount',
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
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

class _MyceliumNetworkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Draw connections
    final linePaint = Paint()
      ..color = AppColors.primaryPurple.withOpacity(0.3)
      ..strokeWidth = 2;

    // Center to surrounding nodes
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * math.pi / 180;
      final radius = 60.0;
      final end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(center, end, linePaint);
    }

    // Draw nodes
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * math.pi / 180;
      final radius = 60.0;
      final pos = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );

      final isActive = i < 4;

      final nodePaint = Paint()
        ..color = isActive
            ? AppColors.primaryPurple
            : AppColors.textSecondary.withOpacity(0.3)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(pos, isActive ? 12 : 8, nodePaint);
    }

    // Draw center node
    final centerPaint = Paint()
      ..color = AppColors.warning
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 16, centerPaint);
  }

  @override
  bool shouldRepaint(_MyceliumNetworkPainter oldDelegate) => false;
}
