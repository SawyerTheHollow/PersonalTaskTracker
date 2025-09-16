import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'user.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://test-mobile.estesis.tech/api/v1/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/register")
  Future<User> registerUser(@Body() User user);

  @POST("/login")
  @FormUrlEncoded()
  Future<Tokens> loginUser(
      @Field("username") String username,
      @Field("password") String password,
  );
}