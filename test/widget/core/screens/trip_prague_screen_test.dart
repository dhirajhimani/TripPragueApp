import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:trip_prague/app/constants/enum.dart';
import 'package:trip_prague/app/constants/route.dart';
import 'package:trip_prague/core/domain/bloc/trip_prague/trip_prague_bloc.dart';
import 'package:trip_prague/core/domain/model/failures.dart';
import 'package:trip_prague/core/presentation/screens/trip_prague_screen.dart';
import 'package:trip_prague/features/home/presentation/screens/home_screen.dart';
import 'package:trip_prague/features/profile/presentation/screens/profile_screen.dart';

import '../../../utils/golden_test_device_scenario.dart';
import '../../../utils/mock_go_router_provider.dart';
import '../../../utils/mock_material_app.dart';
import '../../../utils/test_utils.dart';
import 'trip_prague_screen_test.mocks.dart';

@GenerateMocks(<Type>[TripPragueBloc, GoRouter])
void main() {
  late MockTripPragueBloc tripPragueBloc;
  late MockTripPragueBloc tripPragueBlocError;
  late MockTripPragueBloc tripPragueBlocLoading;
  late MockGoRouter routerHome;
  late MockGoRouter routerProfile;

  setUp(() {
    tripPragueBloc = MockTripPragueBloc();
    tripPragueBlocError = MockTripPragueBloc();
    tripPragueBlocLoading = MockTripPragueBloc();
    routerHome = MockGoRouter();
    routerProfile = MockGoRouter();
    final TripPragueState state = TripPragueState.initial().copyWith(
      authStatus: AuthStatus.authenticated,
      user: mockUser,
      isLoading: false,
    );

    when(tripPragueBloc.stream).thenAnswer(
      (_) => Stream<TripPragueState>.fromIterable(<TripPragueState>[state]),
    );
    when(tripPragueBloc.state).thenAnswer((_) => state);
    when(tripPragueBlocError.stream).thenAnswer(
      (_) => Stream<TripPragueState>.fromIterable(<TripPragueState>[
        state.copyWith(
          failure: const Failure.unexpected('Unexpected Error'),
        ),
      ]),
    );
    when(tripPragueBlocError.state).thenAnswer(
      (_) =>
          state.copyWith(failure: const Failure.unexpected('Unexpected Error')),
    );
    when(tripPragueBlocLoading.stream).thenAnswer(
      (_) => Stream<TripPragueState>.fromIterable(<TripPragueState>[
        state.copyWith(isLoading: true, user: null, failure: null),
      ]),
    );
    when(tripPragueBlocLoading.state).thenAnswer(
      (_) => state.copyWith(isLoading: true, user: null, failure: null),
    );
    when(routerHome.location).thenAnswer((_) => RouteName.home.path);
    when(routerProfile.location).thenAnswer((_) => RouteName.profile.path);
    when(routerProfile.canPop()).thenAnswer((_) => false);
    when(routerHome.canPop()).thenAnswer((_) => false);
  });

  Widget buildTripPragueScreen(
    Widget child,
    GoRouter router,
    TripPragueBloc tripPragueBloc,
  ) =>
      MockMaterialApp(
        child: MockGoRouterProvider(
          router: router,
          child: BlocProvider<TripPragueBloc>(
            create: (BuildContext context) => tripPragueBloc,
            child: Scaffold(
              body: TripPragueScreen(
                child: child,
              ),
            ),
          ),
        ),
      );

  group('TripPrague Screen Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'trip_prague_screen'.goldensVersion,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pumpAndSettle(const Duration(seconds: 1));
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestDeviceScenario(
            name: 'home',
            builder: () =>
                buildTripPragueScreen(const HomeScreen(), routerHome, tripPragueBloc),
          ),
          GoldenTestDeviceScenario(
            name: 'profile',
            builder: () => buildTripPragueScreen(
              const ProfileScreen(),
              routerProfile,
              tripPragueBloc,
            ),
          ),
          GoldenTestDeviceScenario(
            name: 'error',
            builder: () => buildTripPragueScreen(
              const HomeScreen(),
              routerHome,
              tripPragueBlocError,
            ),
          ),
        ],
      ),
    );
    goldenTest(
      'renders correctly',
      fileName: 'trip_prague_screen_loading'.goldensVersion,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pump(const Duration(seconds: 1));
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestDeviceScenario(
            name: 'loading',
            builder: () => buildTripPragueScreen(
              const HomeScreen(),
              routerHome,
              tripPragueBlocLoading,
            ),
          ),
        ],
      ),
    );
  });
}
