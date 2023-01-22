import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_prague/app/constants/route.dart';
import 'package:trip_prague/app/generated/l10n.dart';

class TripPragueNavBar extends StatelessWidget {
  const TripPragueNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.travel_explore),
              label: AppLocalizations.of(context).common_day1.capitalize(),
            ),BottomNavigationBarItem(
              icon: const Icon(Icons.beach_access),
              label: AppLocalizations.of(context).common_day2.capitalize(),
            ),BottomNavigationBarItem(
              icon: const Icon(Icons.done_all),
              label: AppLocalizations.of(context).common_day3.capitalize(),
            ),
          ],
          currentIndex: _getSelectedIndex(context),
          onTap: (int index) => _onItemTapped(index, context),
        ),
      );

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouter.of(context).location;
    if (location.startsWith(RouteName.day1.path)) {
      return 0;
    }
    if (location.startsWith(RouteName.day2.path)) {
      return 1;
    }
    if (location.startsWith(RouteName.day3.path)) {
      return 2;
    }

    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).goNamed(RouteName.day1.name);
        break;
      case 1:
        GoRouter.of(context).goNamed(RouteName.day2.name);
        break;
      case 2:
        GoRouter.of(context).goNamed(RouteName.day3.name);
        break;
      default:
        GoRouter.of(context).goNamed(RouteName.day1.name);
    }
  }
}
