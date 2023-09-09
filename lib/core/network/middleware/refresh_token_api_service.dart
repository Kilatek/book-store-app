import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/core/model/data_response.dart';
import 'package:book_store/core/model/refresh_token_data.dart';
import 'package:book_store/core/network/refresh_rest_client.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RefreshTokenApiService {
  RefreshTokenApiService(this._refreshTokenApiClient);

  final RefreshRestClient _refreshTokenApiClient;

  Future<DataResponse<RefreshTokenData>> refreshToken(
      String refreshToken) async {
    try {
      final respone = await _refreshTokenApiClient.refreshToken();
      return respone;
    } catch (e) {
      throw RefreshTokenException;
    }
  }
}
