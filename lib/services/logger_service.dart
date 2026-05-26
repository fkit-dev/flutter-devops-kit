class LoggerService {
  static void section(String message) {
    print('\n════════════════════════════');
    print('📦 $message');
    print('════════════════════════════\n');
  }

  static void success(String message) {
    print('✅ $message');
  }

  static void error(String message) {
    print('❌ $message');
  }

  static void warning(String message) {
    print('⚠️ $message');
  }

  static void info(String message) {
    print('ℹ️ $message');
  }

  static void command(String message) {
    print('🚀 $message');
  }

  static void divider() {
    print('────────────────────────');
  }

  static void blank() {
    print('');
  }
}
