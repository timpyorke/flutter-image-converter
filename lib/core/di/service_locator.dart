import 'package:flutter_image_converters/providers/shared_pref_provider.dart';
import 'package:flutter_image_converters/services/dialog_service.dart';
import 'package:get_it/get_it.dart';

import '../../services/image_service.dart';
import '../../services/storage_service.dart';
import '../../usecases/convert_and_save_images_usecase.dart';
import '../../viewmodels/conversion_viewmodel.dart';
import '../../viewmodels/navigation_viewmodel.dart';
import '../../viewmodels/resize_viewmodel.dart';
import '../../viewmodels/settings_viewmodel.dart';

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
  //* UseCases - Register as factories
  //**/
  getIt.registerFactory<ConvertAndSaveImagesUseCase>(
    () => ConvertAndSaveImagesUseCase(imageService: getIt<ImageService>()),
  );

  //**
  //* Providers - Register as factories
  //**/

  getIt.registerFactory<SharedPrefProvider>(
    () => SharedPrefProvider(getIt<StorageService>()),
  );

  //**
  //* ViewModels - Register as factories
  //**/
  getIt.registerFactory<NavigationViewModel>(() => NavigationViewModel());

  getIt.registerFactory<SettingsViewModel>(
    () => SettingsViewModel(
      storageService: getIt<StorageService>(),
      dialogService: getIt<DialogService>(),
    ),
  );

  getIt.registerFactory<ConversionViewModel>(
    () => ConversionViewModel(
      imageService: getIt<ImageService>(),
      convertAndSaveUseCase: getIt<ConvertAndSaveImagesUseCase>(),
      storageService: getIt<StorageService>(),
    ),
  );

  getIt.registerFactory<ResizeViewModel>(
    () => ResizeViewModel(
      imageService: getIt<ImageService>(),
      storageService: getIt<StorageService>(),
    ),
  );
}
