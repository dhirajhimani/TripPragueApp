import 'dart:io';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_prague/app/generated/l10n.dart';
import 'package:trip_prague/app/themes/app_colors.dart';
import 'package:trip_prague/app/themes/app_theme.dart';
import 'package:trip_prague/app/themes/spacing.dart';
import 'package:trip_prague/app/themes/text_styles.dart';
import 'package:trip_prague/core/presentation/widgets/trip_prague_dialogs.dart';

class DialogUtils {
  DialogUtils._();

  static Future<void> showSnackbar(
    BuildContext context,
    String message, {
    Duration? duration,
  }) async =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.charcoal,
          duration: duration ?? const Duration(milliseconds: 4000),
          content: Text(
            message,
            style: AppTextStyle.caption.copyWith(color: AppColors.white),
          ),
        ),
      );

  static Future<bool> showExitDialog(BuildContext context) async =>
      await DialogUtils.showConfirmationDialog(
        context,
        message: AppLocalizations.of(context).dialog__message__exit_message,
        onPositivePressed: () {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        },
      ) ??
      false;

  static Future<bool?> showConfirmationDialog(
    BuildContext context, {
    required String message,
    String? title,
    String? negativeButtonText,
    String? positiveButtonText,
    VoidCallback? onNegativePressed,
    VoidCallback? onPositivePressed,
    Color? negativeButtonColor,
    Color? positiveButtonColor,
  }) =>
      showDialog<bool?>(
        context: context,
        builder: (BuildContext context) => ConfirmationDialog(
          message: message,
          title: title,
          negativeButtonText: negativeButtonText,
          positiveButtonText: positiveButtonText,
          onNegativePressed: onNegativePressed,
          onPositivePressed: onPositivePressed,
          negativeButtonColor: negativeButtonColor,
          positiveButtonColor: positiveButtonColor,
        ),
      );

  static Future<void> showToast(
    BuildContext context,
    String message, {
    Icon? icon,
    Duration? duration,
    FlashPosition? position,
  }) =>
      showFlash(
        context: context,
        duration: duration ?? const Duration(seconds: 2),
        builder: (BuildContext context, FlashController<Object?> controller) =>
            Flash<dynamic>.bar(
          controller: controller,
          position: position ?? FlashPosition.top,
          backgroundColor: Theme.of(context).colorScheme.background,
          margin: EdgeInsets.all(Insets.med),
          borderRadius: AppTheme.defaultBoardRadius,
          boxShadows: const <BoxShadow>[
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Insets.lg,
              vertical: Insets.med,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (icon != null)
                  Padding(
                    padding: EdgeInsets.only(right: Insets.sm),
                    child: icon,
                  ),
                Expanded(
                  child: Text(
                    message,
                    style: AppTextStyle.caption,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
