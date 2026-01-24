import 'package:flutter_image_converters/data/providers/shared_pref_provider.dart';
import 'package:flutter_image_converters/core/services/dialog_service.dart';
import 'package:get_it/get_it.dart';

import '../services/image_service.dart';
import '../services/storage_service.dart';
import '../services/permission_service.dart';
import '../../domain/usecases/convert_and_save_images_usecase.dart';
import '../../features/convert/conversion_viewmodel.dart';
import '../../features/home/home_viewmodel.dart';
import '../../features/resize/resize_viewmodel.dart';
import '../../features/settings/settings_viewmodel.dart';

final getIt = GetIt.instance;

/// Initialize dependency injection
Future<void> setupDependencyInjection() async {
  //**
  //* Services - Register as factories
  //**/
  getIt.registerSingletonAsync<StorageService>(
    () => StorageService.getInstance(),
  );
  getIt.registerLazySingleton<ImageService>(() => ImageService());
  getIt.registerLazySingleton<DialogService>(() => DialogService());
  getIt.registerLazySingleton<PermissionService>(() => PermissionService());
  await getIt.isReady<StorageService>();

  //**
  //* Providers - Register as singletons
  //**/
  getIt.registerLazySingleton<SharedPrefProvider>(
    () => SharedPrefProvider(getIt<StorageService>()),
  );

  //**
  //* UseCases - Register as factories
  //**/
  getIt.registerFactory<ConvertAndSaveImagesUseCase>(
    () => ConvertAndSaveImagesUseCase(
      imageService: getIt<ImageService>(),
      permissionService: getIt<PermissionService>(),
    ),
  );

  //**
  //* ViewModels - Register as factories
  //**/
  getIt.registerFactory<NavigationViewModel>(() => NavigationViewModel());

  getIt.registerFactory<SettingsViewModel>(
    () => SettingsViewModel(
      sharedPrefProvider: getIt<SharedPrefProvider>(),
      dialogService: getIt<DialogService>(),
    ),
  );

  getIt.registerFactory<ConversionViewModel>(
    () => ConversionViewModel(
      imageService: getIt<ImageService>(),
      convertAndSaveUseCase: getIt<ConvertAndSaveImagesUseCase>(),
      sharedPrefProvider: getIt<SharedPrefProvider>(),
      dialogService: getIt<DialogService>(),
    ),
  );

  getIt.registerFactory<ResizeViewModel>(
    () => ResizeViewModel(
      imageService: getIt<ImageService>(),
      sharedPrefProvider: getIt<SharedPrefProvider>(),
    ),
  );
}
