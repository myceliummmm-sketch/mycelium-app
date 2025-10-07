import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/telegram_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _api = ApiService();
  final TelegramService _telegram = TelegramService();

  User? _currentUser;
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get error => _error;

  /// Initialize Telegram and authenticate
  Future<void> initialize() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Initialize Telegram Web App
      final isTelegram = _telegram.initialize();

      if (!isTelegram) {
        // Not in Telegram, use mock data for development
        print('⚠️ Not in Telegram, using mock auth');
        await _mockAuth();
      } else {
        // Try to authenticate with Telegram
        try {
          // Get initData from Telegram
          final initData = _telegram.initData;

          if (initData != null && initData.isNotEmpty) {
            // Authenticate with backend using initData
            final response = await _api.telegramAuth(initData);
            _currentUser = User.fromJson(response['user']);
            _isAuthenticated = true;
            print('✅ Authenticated via initData as ${_currentUser!.displayName}');
          } else {
            // Fallback: use userData from Telegram SDK
            final userData = _telegram.userData;
            if (userData != null) {
              print('⚠️ initData empty, using userData from Telegram');
              await _authenticateWithUserData(userData);
            } else {
              print('⚠️ No Telegram data available, using mock auth');
              await _mockAuth();
            }
          }
        } catch (e) {
          print('⚠️ Telegram auth failed: $e, falling back to mock');
          await _mockAuth();
        }
      }
    } catch (e) {
      _error = e.toString();
      print('❌ Auth error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Authenticate with Telegram userData (fallback when initData is empty)
  Future<void> _authenticateWithUserData(Map<String, dynamic> userData) async {
    _currentUser = User(
      id: 'tg-${userData['id']}',
      telegramId: userData['id'],
      username: userData['username'] ?? '',
      firstName: userData['first_name'] ?? 'User',
      lastName: userData['last_name'],
      photoUrl: userData['photo_url'],
      mycTokens: 0,
      level: 1,
      levelProgress: 0.0,
      streakDays: 0,
      stats: UserStats(
        testsCompleted: 0,
        p2pCalls: 0,
        achievements: 0,
      ),
    );

    _isAuthenticated = true;
    print('✅ Authenticated with userData: ${_currentUser!.displayName}');
  }

  /// Mock authentication for development
  Future<void> _mockAuth() async {
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = User(
      id: 'mock-user-id',
      telegramId: 123456789,
      username: 'testuser',
      firstName: 'Test',
      lastName: 'User',
      photoUrl: null,
      mycTokens: 150,
      level: 3,
      levelProgress: 0.65,
      streakDays: 5,
      stats: UserStats(
        testsCompleted: 4,
        p2pCalls: 2,
        achievements: 3,
      ),
    );

    _isAuthenticated = true;
    print('✅ Mock auth successful');
  }

  /// Refresh user data from backend
  Future<void> refreshUser() async {
    if (!_isAuthenticated) return;

    try {
      final userData = await _api.getMe();
      _currentUser = User.fromJson(userData);
      notifyListeners();
    } catch (e) {
      print('Error refreshing user: $e');
    }
  }

  /// Logout
  void logout() {
    _currentUser = null;
    _isAuthenticated = false;
    _api.clearToken();
    notifyListeners();
  }

  /// Update user tokens (optimistic update)
  void updateTokens(int tokens) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(mycTokens: tokens);
      notifyListeners();
    }
  }

  /// Update user level (optimistic update)
  void updateLevel(int level, double progress) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        level: level,
        levelProgress: progress,
      );
      notifyListeners();
    }
  }
}
