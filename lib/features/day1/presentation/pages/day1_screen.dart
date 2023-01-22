import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:trip_prague/core/presentation/screens/day_routine_screen.dart';
import 'package:trip_prague/features/day1/data/models/day1_routine.dart';

class Day1Screen extends HookWidget {
  const Day1Screen({super.key});

  @override
  Widget build(BuildContext context) => DayRoutineScreen(Day1Routines.routines);
}
