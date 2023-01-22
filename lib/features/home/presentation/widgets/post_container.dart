import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_prague/app/constants/route.dart';
import 'package:trip_prague/app/themes/spacing.dart';
import 'package:trip_prague/app/themes/text_styles.dart';
import 'package:trip_prague/core/presentation/widgets/trip_prague_text_url.dart';
import 'package:trip_prague/features/home/domain/model/post.dart';
import 'package:trip_prague/features/home/presentation/widgets/post_container_footer.dart';
import 'package:trip_prague/features/home/presentation/widgets/post_container_header.dart';
import 'package:url_launcher/url_launcher.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: Insets.sm),
        child: GestureDetector(
          onTap: () async => launchPostDetails(context),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(Insets.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  PostContainerHeader(post: post),
                  if (post.urlOverriddenByDest != null)
                    Padding(
                      padding: EdgeInsets.all(Insets.med),
                      child: TripPragueTextUrl(
                        url: post.urlOverriddenByDest!,
                        onTap: () => launchUrl(
                          Uri.parse(post.urlOverriddenByDest!.getOrCrash()),
                        ),
                      ),
                    ),
                  if (post.selftext.getOrCrash().isNotNullOrBlank)
                    Flexible(
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Theme.of(context).cardColor,
                              Theme.of(context).cardColor.withOpacity(0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: IgnorePointer(
                          child: Markdown(
                            shrinkWrap: true,
                            styleSheet:
                                MarkdownStyleSheet(p: AppTextStyle.bodyText2),
                            data: post.selftext.getOrCrash(),
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ),
                      ),
                    ),
                  PostContainerFooter(post: post),
                ],
              ),
            ),
          ),
        ),
      );

  Future<void> launchPostDetails(BuildContext context) async {
    if (kIsWeb) {
      await launchUrl(
        Uri.parse(post.permalink.getOrCrash()),
        webOnlyWindowName: '_blank',
      );
    } else {
      GoRouter.of(context).pushNamed(
        RouteName.postDetails.name,
        params: <String, String>{'postId': post.uid.getOrCrash()},
        extra: post,
      );
    }
  }
}
