import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_prague/app/constants/constant.dart';
import 'package:trip_prague/app/themes/app_colors.dart';
import 'package:trip_prague/app/themes/spacing.dart';
import 'package:trip_prague/app/themes/text_styles.dart';
import 'package:trip_prague/core/domain/bloc/trip_prague/trip_prague_bloc.dart';
import 'package:trip_prague/core/domain/model/value_objects.dart';
import 'package:trip_prague/core/presentation/widgets/trip_prague_avatar.dart';
import 'package:url_launcher/url_launcher.dart';

class TripPragueAppBar extends HookWidget {
  const TripPragueAppBar({
    super.key,
    this.avatar,
  });

  final Url? avatar;

  @override
  Widget build(BuildContext context) => AppBar(
        title: Text(
          Constant.appName,
          style: AppTextStyle.headline5.copyWith(color: AppColors.white),
        ),
        leading: GoRouter.of(context).canPop()
            ? BackButton(
                onPressed: () => GoRouter.of(context).canPop()
                    ? GoRouter.of(context).pop()
                    : null,
              )
            : null,
        actions: <Widget>[
          IconButton(
            onPressed: () => context
                .read<TripPragueBloc>()
                .switchTheme(Theme.of(context).brightness),
            icon: Theme.of(context).brightness == Brightness.dark
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
          ),
          IconButton(
            onPressed: () => launchUrl(
              mode: LaunchMode.externalApplication,
              Uri.parse('https://goo.gl/maps/hcYafA85SC5eb9HQA'),
            ),
            icon: const Icon(Icons.route),
          ),
        ],
      );
}
