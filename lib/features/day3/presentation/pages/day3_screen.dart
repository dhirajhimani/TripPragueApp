import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:trip_prague/core/presentation/screens/day_routine_screen.dart';
import 'package:trip_prague/features/day3/data/models/day3_routine.dart';

class Day3Screen extends HookWidget {
  const Day3Screen({super.key});

  @override
  Widget build(BuildContext context) => DayRoutineScreen(Day3Routines.routines);
}
