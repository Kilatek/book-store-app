import 'package:book_store/core/network/middleware/base_interceptor.dart';
import 'package:book_store/core/network/base/network_constants.dart';
import 'package:book_store/core/preference/app_preferences.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AccessTokenInterceptor extends BaseInterceptor {
  AccessTokenInterceptor(this._appPreferences);

  final AppPreferences _appPreferences;

  @override
  int get priority => BaseInterceptor.accessTokenPriority;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _appPreferences.accessToken;
    if (token.isNotEmpty) {
      options.headers[NetworkConstants.basicAuthorization] =
          '${NetworkConstants.bearer} $token';
    }

    handler.next(options);
  }
}
