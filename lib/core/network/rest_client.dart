import 'package:book_store/core/model/data_response.dart';
import 'package:book_store/features/auth/data/models/auth_response_data.dart';
import 'package:book_store/features/auth/data/models/login_request_data.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/login')
  Future<DataResponse<AuthResponseData>> login(
    @Body() LoginRequesData loginRequesData,
  );
}
