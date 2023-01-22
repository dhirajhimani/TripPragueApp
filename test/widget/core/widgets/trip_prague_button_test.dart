import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_prague/core/presentation/widgets/trip_prague_button.dart';

import '../../../utils/test_utils.dart';

void main() {
  group('TripPragueButton Widget Tests', () {
    int counter = 0;

    GoldenTestGroup buildButtonTestGroup() => GoldenTestGroup(
          children: <Widget>[
            GoldenTestScenario(
              name: 'default',
              child: TripPragueButton(
                text: 'Button',
                onPressed: () => counter++,
              ),
            ),
            GoldenTestScenario(
              name: 'isExpanded',
              constraints: const BoxConstraints(minWidth: 200),
              child: TripPragueButton(
                text: 'Button',
                isExpanded: true,
                onPressed: () => counter++,
              ),
            ),
            GoldenTestScenario(
              name: 'isDisabled',
              child: TripPragueButton(
                text: 'Button',
                isEnabled: false,
                onPressed: () => counter++,
              ),
            ),
            GoldenTestScenario(
              name: 'isDisabled & isExpanded',
              constraints: const BoxConstraints(minWidth: 200),
              child: TripPragueButton(
                text: 'Button',
                isExpanded: true,
                isEnabled: false,
                onPressed: () => counter++,
              ),
            ),
          ],
        );

    goldenTest(
      'renders correctly in initial state',
      fileName: 'trip_prague_button'.goldensVersion,
      builder: buildButtonTestGroup,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pump(const Duration(seconds: 1));
      },
    );
  });
}
