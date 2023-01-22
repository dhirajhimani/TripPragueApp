import 'package:trip_prague/core/data/model/iroutine.dart';

class Day1Routines {
  static final List<IRoutine> routines = [
    DailyRoutine(
      title: '''
    (29.01.2023) B-Südkr 7:23 - Track 3
     Train Number EC 171, 
     3 Sitzplätze, Wg. 258,
     Pl. 81 82 83,
     1 Mitte, 2 Gang,
    ''',
    ),
    DailyRoutine.fromBlock(
      '''
Prague Main Station, Wilsonova, Prague 2-Vinohrady, Czechia
            https://goo.gl/maps/EMJe1vRAaQ45NS4U9
            Prague Main Station Praha hl.n.''',
    ),
    DailyRoutine.fromBlock(
      '''
Miska Ramen Bar
https://goo.gl/maps/Wu3YfyqF8hvbCQTE6
Lunch Option 1
            ''',
    ),
    DailyRoutine.fromBlock(
      '''
Dancing House, Jiráskovo nám. 1981/6, 120 00 Nové Město, Czechia
https://goo.gl/maps/phkeRYXvF5Tgj75o8
walk after Lunch
            ''',
    ),
    DailyRoutine.fromBlock(
      '''
Black Bettie's Grill
https://goo.gl/maps/PDPdiq5MRtAa8MP87
Lunch Option 2
            ''',
    ),
    DailyRoutine(
      title: 'Hotel Don Giovanni Prague, Vinohradská, Prague 3-Žižkov, Czechia',
      description: 'Where we are going to stay',
      url: 'https://goo.gl/maps/majvzTM6xqRHJFMU6',
    ),

    DailyRoutine.fromBlock(
      '''
      Old Town Square, Staroměstské nám., 110 00 Josefov, Czechia
            ''',
    ),

    DailyRoutine.fromBlock(
      '''
      Můstek, 110 00 Prague 1, Czechia
  https://goo.gl/maps/614XZUccdbNNJ5678
            ''',
    ),

    DailyRoutine.fromBlock(
      '''
      Franz Kafka - Rotating Head, Charvátova, 110 00 Nové Město, Czechia
  https://goo.gl/maps/Cu5Xuy4XSE3Q6hwbA
            ''',
    ),
    DailyRoutine.fromBlock(
      '''
      Charles Bridge, Karlův most, 110 00 Praha 1, Czechia
  https://goo.gl/maps/hBGtTgzQYZMTY4zi7
            ''',
    ),
    DailyRoutine.fromBlock(
      '''
      Idiom Installation, Josefov, 110 00 Praha 1, Czechia
  https://goo.gl/maps/pd5hmEKNZJKW7JGs9
            ''',
    ),
    DailyRoutine.fromBlock(
      '''
      Prague Astronomical Clock, Staroměstské nám. 1, 110 00 Josefov, Czechia
  https://goo.gl/maps/BdUjTQgxPcF9N7Yq6
            ''',
    ),
    DailyRoutine.fromBlock(
      '''
      The Powder Tower, nám. Republiky 5, 110 00 Staré Město, Czechia
  https://goo.gl/maps/43WERHX8rLfGpTui8
            ''',
    ),
    DailyRoutine.fromBlock(
      '''
      Dinner Sad Man's Tongue Bar & Bistro
  https://goo.gl/maps/TZvGJ38TpQHvdsqRA
            ''',
    ),

    DailyRoutine(
      title: 'Hotel Don Giovanni Prague, Vinohradská, Prague 3-Žižkov, Czechia',
      description: 'Where we are going to stay',
      url: 'https://goo.gl/maps/majvzTM6xqRHJFMU6',
    ),
  ];
}
