import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:trip_prague/app/constants/enum.dart';
import 'package:trip_prague/core/domain/bloc/trip_prague/trip_prague_bloc.dart';
import 'package:trip_prague/features/profile/presentation/screens/profile_screen.dart';

import '../../../../utils/golden_test_device_scenario.dart';
import '../../../../utils/mock_material_app.dart';
import '../../../../utils/test_utils.dart';
import 'profile_screen_test.mocks.dart';

@GenerateMocks(<Type>[TripPragueBloc])
void main() {
  late MockTripPragueBloc tripPragueBloc;

  setUp(() {
    tripPragueBloc = MockTripPragueBloc();

    when(tripPragueBloc.stream).thenAnswer(
      (_) => Stream<TripPragueState>.fromIterable(<TripPragueState>[
        TripPragueState.initial().copyWith(
          authStatus: AuthStatus.authenticated,
          user: mockUser,
          isLoading: false,
        ),
      ]),
    );
    when(tripPragueBloc.state).thenAnswer(
      (_) => TripPragueState.initial().copyWith(
        authStatus: AuthStatus.authenticated,
        user: mockUser,
        isLoading: false,
      ),
    );
  });
  Widget buildProfileScreen() => BlocProvider<TripPragueBloc>(
        create: (BuildContext context) => tripPragueBloc,
        child: const MockMaterialApp(
          child: Scaffold(
            body: ProfileScreen(),
          ),
        ),
      );

  group('Profile Screen Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'profile_screen'.goldensVersion,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pump(const Duration(seconds: 1));
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestDeviceScenario(
            name: 'default',
            builder: buildProfileScreen,
          ),
        ],
      ),
    );
  });
}
