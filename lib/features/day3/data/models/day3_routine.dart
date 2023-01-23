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
      title: '''
(31.01.2023)Praha 12:25 EC378 Track 8 <> Berlin Südkreuz 31.01. an 16:36 8
EC 378, 3 Sitzplätze, Wg. 258,
Pl. 84 85 86, 2 Fenster, 1 Mitte,
            ''',
    ),

    DailyRoutine(
      title: 'Hotel Don Giovanni Prague, Vinohradská, Prague 3-Žižkov, Czechia',
      description: 'Where we are going to stay',
      url: 'https://goo.gl/maps/majvzTM6xqRHJFMU6',
    ),
  ];
}
