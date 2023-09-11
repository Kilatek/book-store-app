import 'package:async/async.dart';
import 'package:book_store/di/di.dart';

class AppConfig {
  factory AppConfig.getInstance() {
    return _instance;
  }

  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  final AsyncMemoizer<void> _asyncMemoizer = AsyncMemoizer<void>();

  Future<void> init() => _asyncMemoizer.runOnce(config);

  Future<void> config() => configureInjection();
}
