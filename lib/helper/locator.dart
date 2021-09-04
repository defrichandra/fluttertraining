import 'package:flutter_application_sample_1/helper/navigator_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => NavigatorService());
}
