import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:trip_prague/core/presentation/screens/day_routine_screen.dart';
import 'package:trip_prague/features/day2/data/models/day2_routine.dart';

class Day2Screen extends HookWidget {
  const Day2Screen({super.key});

  @override
  Widget build(BuildContext context) => DayRoutineScreen(Day2Routines.routines);
}
