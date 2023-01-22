import 'package:flutter/material.dart';
import 'package:trip_prague/app/constants/constant.dart';
import 'package:trip_prague/app/themes/text_styles.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) => Text(
        Constant.appName,
        style: AppTextStyle.headline1
            .copyWith(color: Theme.of(context).colorScheme.primary),
      );
}
