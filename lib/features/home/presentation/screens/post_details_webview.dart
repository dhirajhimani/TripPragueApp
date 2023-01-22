import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:trip_prague/app/utils/injection.dart';
import 'package:trip_prague/core/domain/model/value_objects.dart';
import 'package:trip_prague/features/home/domain/bloc/post_details/post_details_bloc.dart';
import 'package:trip_prague/features/home/domain/model/post.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PostDetailsWebview extends HookWidget {
  const PostDetailsWebview({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> loadingProgress = useState<int>(0);

    return BlocProvider<PostDetailsBloc>(
      create: (BuildContext context) => getIt<PostDetailsBloc>(
        param1: post.permalink,
        param2: initializeWebViewController(post.permalink, loadingProgress),
      ),
      child: BlocBuilder<PostDetailsBloc, PostDetailsState>(
        builder: (BuildContext context, PostDetailsState state) => WillPopScope(
          onWillPop: () async => context.read<PostDetailsBloc>().webViewBack(),
          child: Center(
            child: Stack(
              children: <Widget>[
                WebViewWidget(controller: state.controller),
                if (loadingProgress.value != 100)
                  LinearProgressIndicator(value: loadingProgress.value / 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static WebViewController initializeWebViewController(
    Url webviewUrl,
    ValueNotifier<int> loadingProgress,
  ) =>
      WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(webviewUrl.getOrCrash()))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) => loadingProgress.value = progress,
            onNavigationRequest: (NavigationRequest request) =>
                NavigationDecision.navigate,
          ),
        );
}
