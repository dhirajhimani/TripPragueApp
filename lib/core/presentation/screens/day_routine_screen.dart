import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:trip_prague/app/themes/spacing.dart';
import 'package:trip_prague/app/themes/text_styles.dart';
import 'package:trip_prague/app/utils/error_message_utils.dart';
import 'package:trip_prague/app/utils/extensions.dart';
import 'package:trip_prague/app/utils/hooks.dart';
import 'package:trip_prague/core/data/model/iroutine.dart';
import 'package:trip_prague/core/domain/bloc/trip_prague/trip_prague_bloc.dart';
import 'package:trip_prague/core/presentation/screens/error_screen.dart';
import 'package:trip_prague/core/presentation/screens/loading_screen.dart';
import 'package:trip_prague/core/presentation/widgets/routine_widget.dart';

class DayRoutineScreen extends HookWidget {
  const DayRoutineScreen(this.routines, {super.key});

  final List<IRoutine> routines;

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController = useRefreshController();

    return BlocBuilder<TripPragueBloc, TripPragueState>(
      builder: (BuildContext context, TripPragueState state) {
        if (state.isLoading) {
          return const LoadingScreen();
        } else if (state.failure != null) {
          return ErrorScreen(
            onRefresh: () async => context.read<TripPragueBloc>().getUser(),
            errorMessage: ErrorMessageUtils.generate(context, state.failure),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              VSpace(Insets.lg),
              Text(
                context.l10n.profile__header_text__basic_information,
                style: AppTextStyle.headline4,
              ),
              VSpace(Insets.lg),
              RoutineOfDay(
                routines: routines,
              ),
            ],
          ),
        );
      },
    );
  }
}
