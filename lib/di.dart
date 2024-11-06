import 'package:air_ticket/api/mock_api.dart';
import 'package:air_ticket/repository/data_repository.dart';
import 'package:air_ticket/repository/local_storage_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Future<void> injectDependencies() async {
  final getIt = GetIt.I;

  final dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
  final mockApi = MockApi(dio);

  final localStorageRepository = LocalStorageRepository();
  await localStorageRepository.init();

  getIt.registerSingleton<DataRepository>(DataRepository(api: mockApi));
  getIt.registerSingleton<LocalStorageRepository>(localStorageRepository);
}
