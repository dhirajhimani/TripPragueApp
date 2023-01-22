import 'package:flutter/material.dart';
import 'package:trip_prague/app/themes/spacing.dart';
import 'package:trip_prague/app/themes/text_styles.dart';
import 'package:trip_prague/core/data/model/iroutine.dart';
import 'package:trip_prague/core/presentation/widgets/modified_stepper.dart'
    as modified_stepper;
import 'package:url_launcher/url_launcher.dart';

class RoutineOfDay extends StatefulWidget {
  const RoutineOfDay({
    super.key,
    required this.routines,
  });

  final List<IRoutine> routines;

  @override
  State<RoutineOfDay> createState() => _RoutineOfDayState();
}

class _RoutineOfDayState extends State<RoutineOfDay> {
  @override
  Widget build(BuildContext context) => Expanded(
        child: modified_stepper.ModifiedStepper(
          controlsBuilder: (BuildContext context,
                  modified_stepper.ControlsDetails controls) =>
              const SizedBox.shrink(),
          steps: widget.routines
              .map(
                (IRoutine routine) => modified_stepper.Step(
                  isActive: true,
                  title: Text(
                    routine.title,
                    style: AppTextStyle.headline6,
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      VSpace(Insets.lg),
                      Text(
                        routine.description ?? '',
                        style: AppTextStyle.headline5,
                      ),
                      VSpace(Insets.lg),
                      InkWell(
                        onTap: () => launchUrl(
                          Uri.parse(routine.url ?? ''),
                        ),
                        child: Text(
                          routine.url ?? '',
                          style: AppTextStyle.subtitle1.copyWith(
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      );
}
