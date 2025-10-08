import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';
import '../config/app_version.dart';
import '../widgets/myc_coin_icon.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool _isMyceliumExpanded = false;

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

                // Your Mycelium card - expandable
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isMyceliumExpanded = !_isMyceliumExpanded;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
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
                            Row(
                              children: [
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
                                const SizedBox(width: 8),
                                Icon(
                                  _isMyceliumExpanded
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ],
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
                        // Expanded content - invite friends
                        if (_isMyceliumExpanded) ...[
                          const SizedBox(height: 24),
                          const Divider(color: Colors.white24, height: 1),
                          const SizedBox(height: 20),
                          const Text(
                            '🤝 Пригласить друзей',
                            style: AppTextStyles.h3,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Приглашайте друзей и получайте награды. Каждый приглашенный друг повышает ваш Trust Score и открывает новые возможности.',
                            style: AppTextStyles.body,
                          ),
                          const SizedBox(height: 16),
                          // Mycelium network visualization
                          Center(
                            child: CustomPaint(
                              size: const Size(200, 180),
                              painter: _MyceliumNetworkPainter(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
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
                      ],
                    ),
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
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Center(
                              child: Text('🎙️', style: TextStyle(fontSize: 28)),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Еженедельный созвон',
                                  style: AppTextStyles.h2.copyWith(fontSize: 18),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'С основателем',
                                  style: AppTextStyles.body.copyWith(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                                  size: 16,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Каждую пятницу, 18:00 МСК',
                                    style: AppTextStyles.body.copyWith(fontSize: 13),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.people,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '23 участника записались',
                                    style: AppTextStyles.body.copyWith(fontSize: 13),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                            const MycCoinIcon(size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Стоимость: 50 MYC',
                              style: AppTextStyles.h3.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
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
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Купить билет 🎫',
                            style: TextStyle(
                              fontSize: 16,
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

                // World Map - Full width
                GestureDetector(
                  onTap: () {
                    _showWorldMap(context);
                  },
                  child: Container(
                    height: 120,
                    padding: const EdgeInsets.all(16),
                    decoration: AppDecorations.gradientCard(
                      AppGradients.blueGradient,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🗺️', style: TextStyle(fontSize: 40)),
                        const SizedBox(width: 16),
                        Text(
                          'Карта резидентов',
                          style: AppTextStyles.h2.copyWith(fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ).animate(delay: 300.ms).fadeIn().scale(begin: const Offset(0.9, 0.9)),

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

                    // Interactive world map with cities
                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primaryBlue.withOpacity(0.15),
                            AppColors.primaryPurple.withOpacity(0.1),
                          ],
                        ),
                        border: Border.all(
                          color: AppColors.primaryBlue.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Stack(
                          children: [
                            // World map background
                            CustomPaint(
                              painter: _WorldMapPainter(),
                              size: const Size(double.infinity, 350),
                            ),
                            // City markers with user counts
                            _buildCityMarker(165, 80, 'Москва', 247),
                            _buildCityMarker(155, 70, 'Питер', 89),
                            _buildCityMarker(100, 180, 'Нью-Йорк', 156),
                            _buildCityMarker(250, 200, 'Сингапур', 45),
                            _buildCityMarker(200, 140, 'Дубай', 67),
                            _buildCityMarker(135, 95, 'Берлин', 123),
                            // Connection lines between cities
                            CustomPaint(
                              painter: _ConnectionLinesPainter(),
                              size: const Size(double.infinity, 350),
                            ),
                          ],
                        ),
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

  Widget _buildCityMarker(double left, double top, String cityName, int userCount) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$cityName: $userCount участников'),
              duration: const Duration(seconds: 2),
              backgroundColor: AppColors.primaryPurple,
            ),
          );
        },
        child: Column(
          children: [
            // Pulsing city marker
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                gradient: AppGradients.primaryGradient,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPurple.withOpacity(0.5),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  userCount.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat()).scale(
                  duration: 2000.ms,
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1.1, 1.1),
                ),
            const SizedBox(height: 4),
            // City label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.background.withOpacity(0.9),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppColors.primaryBlue.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Text(
                cityName,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
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
                const MycCoinIcon(size: 16),
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

// World Map Painter with continent contours
class _WorldMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryBlue.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = AppColors.primaryBlue.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Simplified continent shapes (approximate)
    // Europe
    final europePath = Path()
      ..moveTo(size.width * 0.48, size.height * 0.25)
      ..lineTo(size.width * 0.52, size.height * 0.22)
      ..lineTo(size.width * 0.56, size.height * 0.25)
      ..lineTo(size.width * 0.54, size.height * 0.35)
      ..lineTo(size.width * 0.48, size.height * 0.35)
      ..close();
    canvas.drawPath(europePath, paint);
    canvas.drawPath(europePath, borderPaint);

    // Asia
    final asiaPath = Path()
      ..moveTo(size.width * 0.58, size.height * 0.20)
      ..lineTo(size.width * 0.75, size.height * 0.18)
      ..lineTo(size.width * 0.82, size.height * 0.30)
      ..lineTo(size.width * 0.78, size.height * 0.45)
      ..lineTo(size.width * 0.70, size.height * 0.50)
      ..lineTo(size.width * 0.58, size.height * 0.38)
      ..close();
    canvas.drawPath(asiaPath, paint);
    canvas.drawPath(asiaPath, borderPaint);

    // North America
    final northAmericaPath = Path()
      ..moveTo(size.width * 0.15, size.height * 0.20)
      ..lineTo(size.width * 0.28, size.height * 0.18)
      ..lineTo(size.width * 0.35, size.height * 0.28)
      ..lineTo(size.width * 0.32, size.height * 0.42)
      ..lineTo(size.width * 0.22, size.height * 0.48)
      ..lineTo(size.width * 0.12, size.height * 0.38)
      ..close();
    canvas.drawPath(northAmericaPath, paint);
    canvas.drawPath(northAmericaPath, borderPaint);

    // South America
    final southAmericaPath = Path()
      ..moveTo(size.width * 0.28, size.height * 0.50)
      ..lineTo(size.width * 0.35, size.height * 0.48)
      ..lineTo(size.width * 0.34, size.height * 0.68)
      ..lineTo(size.width * 0.30, size.height * 0.75)
      ..lineTo(size.width * 0.26, size.height * 0.70)
      ..close();
    canvas.drawPath(southAmericaPath, paint);
    canvas.drawPath(southAmericaPath, borderPaint);

    // Africa
    final africaPath = Path()
      ..moveTo(size.width * 0.48, size.height * 0.38)
      ..lineTo(size.width * 0.58, size.height * 0.40)
      ..lineTo(size.width * 0.56, size.height * 0.65)
      ..lineTo(size.width * 0.50, size.height * 0.68)
      ..lineTo(size.width * 0.46, size.height * 0.58)
      ..close();
    canvas.drawPath(africaPath, paint);
    canvas.drawPath(africaPath, borderPaint);

    // Australia
    final australiaPath = Path()
      ..moveTo(size.width * 0.75, size.height * 0.60)
      ..lineTo(size.width * 0.85, size.height * 0.58)
      ..lineTo(size.width * 0.88, size.height * 0.68)
      ..lineTo(size.width * 0.82, size.height * 0.72)
      ..lineTo(size.width * 0.74, size.height * 0.68)
      ..close();
    canvas.drawPath(australiaPath, paint);
    canvas.drawPath(australiaPath, borderPaint);
  }

  @override
  bool shouldRepaint(_WorldMapPainter oldDelegate) => false;
}

// Connection lines between cities
class _ConnectionLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.primaryPurple.withOpacity(0.15)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dashPaint = Paint()
      ..color = AppColors.primaryBlue.withOpacity(0.25)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // City positions (matching the markers in the Stack)
    final moscow = const Offset(165, 80);
    final petersburg = const Offset(155, 70);
    final newYork = const Offset(100, 180);
    final singapore = const Offset(250, 200);
    final dubai = const Offset(200, 140);
    final berlin = const Offset(135, 95);

    // Draw connection lines
    _drawDashedLine(canvas, moscow, petersburg, dashPaint);
    _drawDashedLine(canvas, moscow, dubai, dashPaint);
    _drawDashedLine(canvas, moscow, berlin, dashPaint);
    _drawDashedLine(canvas, berlin, newYork, dashPaint);
    _drawDashedLine(canvas, dubai, singapore, dashPaint);
    _drawDashedLine(canvas, newYork, dubai, dashPaint);
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double distance = (end - start).distance;
    double traveled = 0;

    while (traveled < distance) {
      final startPoint = Offset.lerp(start, end, traveled / distance)!;
      traveled += dashWidth;
      final endPoint = traveled > distance
          ? end
          : Offset.lerp(start, end, traveled / distance)!;
      canvas.drawLine(startPoint, endPoint, paint);
      traveled += dashSpace;
    }
  }

  @override
  bool shouldRepaint(_ConnectionLinesPainter oldDelegate) => false;
}
