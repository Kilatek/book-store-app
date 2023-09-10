import 'package:book_store/core/preference/shared_preference_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class AppPreferences {
  AppPreferences(this._sharedPreference, this._secureStorage);

  final SharedPreferences _sharedPreference;
  final FlutterSecureStorage _secureStorage;

  Future<String> get deviceToken async {
    return await _secureStorage.read(key: SharedPreferenceKeys.deviceToken) ??
        '';
  }

  Future<String> get accessToken async {
    return await _secureStorage.read(key: SharedPreferenceKeys.accessToken) ??
        '';
  }

  Future<String> get refreshToken async {
    return await _secureStorage.read(key: SharedPreferenceKeys.refreshToken) ??
        '';
  }

  bool get isLoggedIn {
    final token =
        _sharedPreference.getString(SharedPreferenceKeys.accessToken) ?? '';

    return token.isNotEmpty;
  }

  Future<void> saveAccessToken(String token) async {
    return _secureStorage.write(
      key: SharedPreferenceKeys.accessToken,
      value: token,
    );
  }

  Future<void> saveRefreshToken(String token) async {
    return _secureStorage.write(
      key: SharedPreferenceKeys.refreshToken,
      value: token,
    );
  }

  Future<void> saveDeviceToken(String token) {
    return _secureStorage.write(
      key: SharedPreferenceKeys.deviceToken,
      value: token,
    );
  }

  Future<void> clearCurrentUserData() async {
    await Future.wait(
      [
        _sharedPreference.remove(SharedPreferenceKeys.accessToken),
        _sharedPreference.remove(SharedPreferenceKeys.refreshToken),
      ],
    );
  }
}
