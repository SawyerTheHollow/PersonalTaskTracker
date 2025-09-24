import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:first_flutter_project/api/api_client.dart';
import 'package:hive_flutter/hive_flutter.dart';

//GetIt
final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {

  await Hive.initFlutter();
  final box = await Hive.openBox('taskStorage');
  getIt.registerSingleton<Box>(box);
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));
  getIt.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());

  await getIt.allReady();
}
//GetIt