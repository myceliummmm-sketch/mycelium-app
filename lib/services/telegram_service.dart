import 'dart:html' as html;
import 'dart:js_util' as js_util;

class TelegramService {
  static final TelegramService _instance = TelegramService._internal();
  factory TelegramService() => _instance;
  TelegramService._internal();

  dynamic _webApp;
  bool _isInitialized = false;

  /// Initialize Telegram Web App
  bool initialize() {
    if (_isInitialized) return true;

    try {
      final telegram = js_util.getProperty(html.window, 'Telegram');
      if (telegram != null) {
        _webApp = js_util.getProperty(telegram, 'WebApp');
        _isInitialized = _webApp != null;

        if (_isInitialized) {
          print('✅ Telegram Web App initialized');
        }

        return _isInitialized;
      }
    } catch (e) {
      print('⚠️ Telegram Web App not available: $e');
    }

    return false;
  }

  /// Check if running in Telegram
  bool get isInTelegram => _isInitialized && _webApp != null;

  /// Get Telegram initData for authentication
  String? get initData {
    if (!_isInitialized) return null;
    try {
      final data = js_util.getProperty(_webApp, 'initData');
      return data?.toString();
    } catch (e) {
      print('Error getting initData: $e');
      return null;
    }
  }

  /// Get user data from Telegram
  Map<String, dynamic>? get userData {
    if (!_isInitialized) return null;
    try {
      final initDataUnsafe = js_util.getProperty(_webApp, 'initDataUnsafe');
      if (initDataUnsafe != null) {
        final user = js_util.getProperty(initDataUnsafe, 'user');
        if (user != null) {
          return {
            'id': js_util.getProperty(user, 'id'),
            'first_name': js_util.getProperty(user, 'first_name'),
            'last_name': js_util.getProperty(user, 'last_name'),
            'username': js_util.getProperty(user, 'username'),
            'photo_url': js_util.getProperty(user, 'photo_url'),
          };
        }
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
    return null;
  }

  /// Get Telegram Web App version
  String? get version {
    if (!_isInitialized) return null;
    try {
      return js_util.getProperty(_webApp, 'version')?.toString();
    } catch (e) {
      return null;
    }
  }

  /// Expand app to full height
  void expand() {
    if (!_isInitialized) return;
    try {
      js_util.callMethod(_webApp, 'expand', []);
    } catch (e) {
      print('Error expanding: $e');
    }
  }

  /// Close the app
  void close() {
    if (!_isInitialized) return;
    try {
      js_util.callMethod(_webApp, 'close', []);
    } catch (e) {
      print('Error closing: $e');
    }
  }

  /// Show main button
  void showMainButton(String text, void Function() onClick) {
    if (!_isInitialized) return;
    try {
      final mainButton = js_util.getProperty(_webApp, 'MainButton');
      js_util.callMethod(mainButton, 'setText', [text]);
      js_util.callMethod(mainButton, 'show', []);
      js_util.callMethod(mainButton, 'onClick', [onClick]);
    } catch (e) {
      print('Error showing main button: $e');
    }
  }

  /// Hide main button
  void hideMainButton() {
    if (!_isInitialized) return;
    try {
      final mainButton = js_util.getProperty(_webApp, 'MainButton');
      js_util.callMethod(mainButton, 'hide', []);
    } catch (e) {
      print('Error hiding main button: $e');
    }
  }

  /// Show alert
  void showAlert(String message) {
    if (!_isInitialized) return;
    try {
      js_util.callMethod(_webApp, 'showAlert', [message]);
    } catch (e) {
      print('Error showing alert: $e');
    }
  }

  /// Show confirm dialog
  Future<bool> showConfirm(String message) async {
    if (!_isInitialized) return false;
    try {
      final result = await js_util.promiseToFuture(
        js_util.callMethod(_webApp, 'showConfirm', [message]),
      );
      return result == true;
    } catch (e) {
      print('Error showing confirm: $e');
      return false;
    }
  }

  /// Haptic feedback
  void hapticFeedback(String type) {
    if (!_isInitialized) return;
    try {
      final haptic = js_util.getProperty(_webApp, 'HapticFeedback');
      js_util.callMethod(haptic, 'impactOccurred', [type]);
    } catch (e) {
      print('Error with haptic feedback: $e');
    }
  }

  /// Open link in Telegram browser
  void openLink(String url) {
    if (!_isInitialized) return;
    try {
      js_util.callMethod(_webApp, 'openLink', [url]);
    } catch (e) {
      print('Error opening link: $e');
    }
  }

  /// Open Telegram link
  void openTelegramLink(String url) {
    if (!_isInitialized) return;
    try {
      js_util.callMethod(_webApp, 'openTelegramLink', [url]);
    } catch (e) {
      print('Error opening Telegram link: $e');
    }
  }
}
