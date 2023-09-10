import 'package:book_store/core/model/data_response.dart';
import 'package:book_store/core/model/refresh_token_data.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'refresh_rest_client.g.dart';

@RestApi()
abstract class RefreshRestClient {
  factory RefreshRestClient(Dio dio, {String baseUrl}) = _RefreshRestClient;

  @POST('/v1/auth/refresh')
  Future<DataResponse<RefreshTokenData>> refreshToken();
}
