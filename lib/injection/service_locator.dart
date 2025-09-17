import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:first_flutter_project/api/api_client.dart';

//GetIt
final GetIt getIt = GetIt.instance;

void setupLocator(){
getIt.registerLazySingleton<Dio>(() => Dio());
getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));
getIt.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
}
//GetIt