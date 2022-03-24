import 'package:data/core/api_key.dart';
import 'package:data/dio/dio_builder.dart';
import 'package:data/repository/network_repository.dart';
import 'package:data/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:domain/repository/network_repository.dart';
import 'package:get_it/get_it.dart';

Future<void> initDataModule() async {
  _initRepositoryModule();
  _initApiModule();
}

void _initApiModule() {
  GetIt.I.registerFactory<CancelToken>(() => CancelToken());
  _initDioModule();
  _initServiceModule();
}

void _initRepositoryModule() {
  GetIt.I.registerFactory<INetworkRepository>(
    () => NetworkRepository(
      GetIt.I.get<ApiService>(),
      GetIt.I.get<CancelToken>(),
    ),
  );
}

void _initDioModule() {
  GetIt.I.registerSingleton(
    dioBuilder(ApiHelperCore.baseUrl, headers: ApiHelperCore.authHeader),
    instanceName: "plazo",
  );
}

void _initServiceModule() {
  GetIt.I.registerSingleton(
    ApiService(GetIt.I.get<Dio>(instanceName: "plazo")),
  );
}