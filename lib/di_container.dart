import 'package:asthma_monitor/data/repository/result_repo.dart';
import 'package:asthma_monitor/provider/SliderProvider.dart';
import 'package:asthma_monitor/provider/result_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:asthma_monitor/data/repository/analyze_repo.dart';
import 'package:asthma_monitor/data/repository/auth_repo.dart';
import 'package:asthma_monitor/data/repository/language_repo.dart';
import 'package:asthma_monitor/data/repository/profile_repo.dart';
import 'package:asthma_monitor/provider/analyze_provider.dart';
import 'package:asthma_monitor/provider/auth_provider.dart';
import 'package:asthma_monitor/provider/language_provider.dart';
import 'package:asthma_monitor/provider/localization_provider.dart';
import 'package:asthma_monitor/provider/profile_provider.dart';
import 'package:asthma_monitor/provider/theme_provider.dart';
import 'package:asthma_monitor/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());

  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => LanguageRepo());
  sl.registerLazySingleton(
      () => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => ProfileRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => AnalyzeRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => ResultRepo(dioClient: sl(), sharedPreferences: sl()));

  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LanguageProvider(languageRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => AnalyzeProvider(analyzeRepo: sl()));
  sl.registerFactory(() => SliderProvider());
  sl.registerFactory(() => ResultProvider(resultRepo: sl()));

  // sl.registerFactory(
  //     () => GluecoseMonitoringProvider(gulecoseMonitoringRepo: sl()));
  // sl.registerFactory(() => GluecoseProvider(gluecoseRepo: sl()));
}
