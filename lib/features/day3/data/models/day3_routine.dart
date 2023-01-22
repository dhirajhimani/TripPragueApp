import 'package:trip_prague/core/data/model/iroutine.dart';

class Day3Routines {
  static final List<IRoutine> routines = [
    DailyRoutine.fromBlock(
      '''
Prague Main Station, Wilsonova, Prague 2-Vinohrady, Czechia
            https://goo.gl/maps/EMJe1vRAaQ45NS4U9
            Prague Main Station Praha hl.n.''',
    ),
    DailyRoutine(
      title: 'Hotel Don Giovanni Prague, Vinohradská, Prague 3-Žižkov, Czechia',
      description: 'Where we are going to stay',
      url: 'https://goo.gl/maps/majvzTM6xqRHJFMU6',
    ),
  ];
}
