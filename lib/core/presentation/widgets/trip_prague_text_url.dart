import 'package:flutter/material.dart';

import 'package:trip_prague/app/themes/spacing.dart';
import 'package:trip_prague/app/themes/text_styles.dart';
import 'package:trip_prague/core/domain/model/value_objects.dart';

class TripPragueTextUrl extends StatelessWidget {
  const TripPragueTextUrl({
    super.key,
    required this.url,
    required this.onTap,
    this.style,
    this.isShowIcon = true,
  });

  final Url url;
  final TextStyle? style;
  final bool isShowIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                url.getOrCrash(),
                style: style?.copyWith(decoration: TextDecoration.underline) ??
                    AppTextStyle.caption.copyWith(
                      color: Colors.lightBlue,
                      decoration: TextDecoration.underline,
                    ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                textWidthBasis: TextWidthBasis.longestLine,
                maxLines: 1,
              ),
            ),
            if (isShowIcon)
              Padding(
                padding: EdgeInsets.only(left: Insets.xxs),
                child: Icon(
                  Icons.open_in_new,
                  color: Colors.lightBlue,
                  size: style?.fontSize ?? AppTextStyle.caption.fontSize,
                ),
              ),
          ],
        ),
      );
}
