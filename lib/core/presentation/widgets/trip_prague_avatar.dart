import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TripPragueAvatar extends StatelessWidget {
  const TripPragueAvatar({
    super.key,
    required this.size,
    this.imageUrl,
    this.padding,
  });

  final String? imageUrl;
  final double size;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) => Semantics(
        image: true,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: imageUrl != null
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  imageBuilder: (
                    BuildContext context,
                    ImageProvider<Object> imageProvider,
                  ) =>
                      Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  fit: BoxFit.cover,
                  errorWidget:
                      (BuildContext context, String url, dynamic error) =>
                          Icon(Icons.account_circle, size: size),
                )
              : Icon(Icons.account_circle, size: size),
        ),
      );
}
