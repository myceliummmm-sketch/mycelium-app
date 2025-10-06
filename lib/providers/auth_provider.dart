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
        if (kDebugMode) {
          print('⚠️ Not in Telegram, using mock auth');
          await _mockAuth();
        } else {
          throw Exception('This app must be opened in Telegram');
        }
      } else {
        // Get initData from Telegram
        final initData = _telegram.initData;
        if (initData == null || initData.isEmpty) {
          throw Exception('Failed to get Telegram auth data');
        }

        // Authenticate with backend
        final response = await _api.telegramAuth(initData);

        // Parse user data
        _currentUser = User.fromJson(response['user']);
        _isAuthenticated = true;

        print('✅ Authenticated as ${_currentUser!.displayName}');
      }
    } catch (e) {
      _error = e.toString();
      print('❌ Auth error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
