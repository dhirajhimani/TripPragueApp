import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_prague/app/config/scroll_behavior.dart';
import 'package:trip_prague/app/constants/constant.dart';
import 'package:trip_prague/app/generated/l10n.dart';
import 'package:trip_prague/app/routes/app_router.dart';
import 'package:trip_prague/app/themes/app_theme.dart';
import 'package:trip_prague/app/utils/injection.dart';
import 'package:trip_prague/core/domain/bloc/trip_prague/trip_prague_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends StatelessWidget {
  App({super.key});

  final GoRouter routerConfig =
      getIt<AppRouter>(param1: getIt<TripPragueBloc>()).router;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<TripPragueBloc>(
            create: (BuildContext context) => getIt<TripPragueBloc>(),
          ),
        ],
        child: BlocBuilder<TripPragueBloc, TripPragueState>(
          builder: (BuildContext context, TripPragueState state) =>
              MaterialApp.router(
            title: Constant.appName,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            debugShowCheckedModeBanner: false,
            scrollBehavior: ScrollBehaviorConfig(),
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.delegate.supportedLocales,
            builder: (BuildContext context, Widget? widget) =>
                ResponsiveWrapper.builder(
              widget,
              minWidth: Constant.mobileBreakpoint,
              breakpoints: const <ResponsiveBreakpoint>[
                ResponsiveBreakpoint.autoScaleDown(
                  Constant.mobileBreakpoint,
                  name: PHONE,
                ),
                ResponsiveBreakpoint.resize(
                  Constant.mobileBreakpoint,
                  name: MOBILE,
                ),
                ResponsiveBreakpoint.resize(
                  Constant.tabletBreakpoint,
                  name: TABLET,
                ),
                ResponsiveBreakpoint.resize(
                  Constant.desktopBreakpoint,
                  name: DESKTOP,
                ),
              ],
            ),
            routerConfig: routerConfig,
          ),
        ),
      );
}
