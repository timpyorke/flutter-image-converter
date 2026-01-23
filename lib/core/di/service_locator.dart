import 'package:flutter_image_converters/providers/shared_pref_provider.dart';
import 'package:flutter_image_converters/core/services/dialog_service.dart';
import 'package:get_it/get_it.dart';

import '../services/image_service.dart';
import '../services/storage_service.dart';
import '../usecases/convert_and_save_images_usecase.dart';
import '../../presentation/viewmodels/conversion_viewmodel.dart';
import '../../presentation/viewmodels/navigation_viewmodel.dart';
import '../../presentation/viewmodels/resize_viewmodel.dart';
import '../../presentation/viewmodels/settings_viewmodel.dart';

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
    () => ConvertAndSaveImagesUseCase(imageService: getIt<ImageService>()),
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
