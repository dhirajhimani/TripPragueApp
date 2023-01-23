import 'package:flutter/material.dart';
import 'package:trip_prague/app/themes/text_styles.dart';
import 'package:trip_prague/core/data/model/iroutine.dart';
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
    child: ListView.builder(
          itemCount: widget.routines.length,
          itemBuilder: (_, int index) => Card(
            child: ListTile(
              title: Text(
                widget.routines[index].title,
                style: AppTextStyle.headline6,
              ),
              leading: Text(
                (index + 1).toString(),
                style: AppTextStyle.headline6,
              ),
              subtitle: Text(
                widget.routines[index].description ?? '',
                style: AppTextStyle.headline5,
              ),
              trailing: const Icon(Icons.map),
              onTap: () => launchUrl(
                  mode:LaunchMode.externalApplication,
                Uri.parse(widget.routines[index].url ?? ''),
              ),
            ),
          ),
        ),
  );
}
