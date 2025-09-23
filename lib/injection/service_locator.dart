import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:first_flutter_project/api/api_client.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

//GetIt
final GetIt getIt = GetIt.instance;

void setupLocator() async {
getIt.registerLazySingleton<Dio>(() => Dio());
getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));
getIt.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());

final dir = await getApplicationDocumentsDirectory();
Hive.init(dir.path);
final box = await Hive.openBox('taskStorage');
/*Попытка сдружить hive и get_it
getIt.registerSingleton<Box>(box, instanceName: 'taskStorage');
*/
await getIt.allReady();
}
//GetIt