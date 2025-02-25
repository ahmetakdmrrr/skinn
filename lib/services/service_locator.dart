import 'package:get_it/get_it.dart';
import 'auth/auth_service.dart';
import 'storage/storage_service.dart';
import 'ml/ml_service.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Auth Service
  // serviceLocator.registerSingleton<AuthService>(HMSAuthService()); // Will be implemented later

  // Storage Service
  // serviceLocator.registerSingleton<StorageService>(HMSStorageService()); // Will be implemented later

  // ML Service
  // serviceLocator.registerSingleton<MLService>(HMSMLService()); // Will be implemented later

  // Initialize all services
  // await Future.wait([
  //   serviceLocator<AuthService>().initialize(),
  //   serviceLocator<StorageService>().initialize(),
  //   serviceLocator<MLService>().initialize(),
  // ]);
}
