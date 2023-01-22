import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:trip_prague/app/constants/route.dart';
import 'package:trip_prague/core/presentation/widgets/trip_prague_nav_bar.dart';

import '../../../utils/mock_go_router_provider.dart';
import '../../../utils/mock_localization.dart';
import '../../../utils/test_utils.dart';
import 'trip_prague_nav_bar_test.mocks.dart';

@GenerateMocks(<Type>[GoRouter])
void main() {
  late MockGoRouter routerHome;
  late MockGoRouter routerProfile;

  setUp(() {
    routerHome = MockGoRouter();
    routerProfile = MockGoRouter();
    when(routerHome.location).thenAnswer((_) => RouteName.home.path);
    when(routerProfile.location).thenAnswer((_) => RouteName.profile.path);
  });
  group('TripPragueNavBar Widget Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'trip_prague_nav_bar'.goldensVersion,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pumpAndSettle();
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestScenario(
            name: 'home tab is selected',
            constraints: const BoxConstraints(minWidth: 400),
            child: MockLocalization(
              child: MockGoRouterProvider(
                router: routerHome,
                child: PreferredSize(
                  preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                  child: const TripPragueNavBar(),
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'profile tab is selected',
            constraints: const BoxConstraints(minWidth: 400),
            child: MockLocalization(
              child: MockGoRouterProvider(
                router: routerProfile,
                child: PreferredSize(
                  preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                  child: const TripPragueNavBar(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  });
}
