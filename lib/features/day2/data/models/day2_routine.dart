import 'package:trip_prague/core/data/model/iroutine.dart';

class Day2Routines {
  static final List<IRoutine> routines = [
    DailyRoutine.fromBlock(
      '''
Prague Castle, Hradčany, Prague 1, Czechia
https://goo.gl/maps/FoRJmofWZzb72Jqj6
''',
    ),
    DailyRoutine.fromBlock(
      '''
Petrin Tower, Petřínské sady, Prague 1-Malá Strana, Czechia
https://goo.gl/maps/TXx3F2cGkQnqDFKr9
''',
    ),
    DailyRoutine(
      title: 'Hotel Don Giovanni Prague, Vinohradská, Prague 3-Žižkov, Czechia',
      description: 'Where we are going to stay',
      url: 'https://goo.gl/maps/majvzTM6xqRHJFMU6',
    ),
  ];
}
