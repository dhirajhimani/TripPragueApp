import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:trip_prague/app/config/chopper_config.dart';
import 'package:trip_prague/app/config/url_strategy_native.dart'
    if (dart.library.html) 'package:trip_prague/app/config/url_strategy_web.dart';
import 'package:trip_prague/app/constants/enum.dart';
import 'package:trip_prague/app/generated/assets.gen.dart';
import 'package:trip_prague/app/observers/app_bloc_observer.dart';
import 'package:trip_prague/app/utils/injection.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder, Env env) async {
  WidgetsFlutterBinding.ensureInitialized();
  urlConfig();
  initializeSingletons();
  await initializeEnvironmentConfig(env);
  await configureDependencies(env);

  Bloc.observer = getIt<AppBlocObserver>();
  final Logger logger = getIt<Logger>();

  FlutterError.onError = (FlutterErrorDetails details) {
    logger.e(details.exceptionAsString(), details, details.stack);
  };

  await runZonedGuarded(
    () async => runApp(await builder()),
    (Object error, StackTrace stackTrace) =>
        logger.e(error.toString(), error, stackTrace),
  );
}

void initializeSingletons() {
  getIt
    ..registerLazySingleton<Logger>(
      () => Logger(
        filter: ProductionFilter(),
        printer: PrettyPrinter(),
        output: ConsoleOutput(),
      ),
    )
    ..registerLazySingleton<ChopperClient>(() => ChopperConfig.client);
}

Future<void> initializeEnvironmentConfig(Env env) async {
  switch (env) {
    case Env.development:
    case Env.test:
      await dotenv.load(fileName: Assets.env.envDevelopment);
      break;
    case Env.staging:
      await dotenv.load(fileName: Assets.env.envStaging);
      break;
    case Env.production:
      await dotenv.load(fileName: Assets.env.envProduction);
      break;
  }
}
