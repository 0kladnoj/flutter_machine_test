import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final locator = GetIt.I;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
GetIt configureDependencies([
  Environment environment = const Environment(Environment.dev),
]) {
  return $initGetIt(locator, environment: environment.name);
}
