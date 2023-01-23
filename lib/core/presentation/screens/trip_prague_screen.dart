import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_prague/app/constants/constant.dart';
import 'package:trip_prague/app/utils/dialog_utils.dart';
import 'package:trip_prague/app/utils/error_message_utils.dart';
import 'package:trip_prague/app/utils/injection.dart';
import 'package:trip_prague/core/domain/bloc/trip_prague/trip_prague_bloc.dart';
import 'package:trip_prague/core/presentation/screens/error_screen.dart';
import 'package:trip_prague/core/presentation/widgets/connectivity_checker.dart';
import 'package:trip_prague/core/presentation/widgets/trip_prague_app_bar.dart';
import 'package:trip_prague/core/presentation/widgets/trip_prague_nav_bar.dart';
import 'package:trip_prague/features/home/domain/bloc/post/post_bloc.dart';

class TripPragueScreen extends StatelessWidget {
  const TripPragueScreen({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => DialogUtils.showExitDialog(context),
        child: MultiBlocProvider(
          providers: <BlocProvider<dynamic>>[
            BlocProvider<PostBloc>(
              create: (BuildContext context) => getIt<PostBloc>(),
            ),
          ],
          child: BlocBuilder<TripPragueBloc, TripPragueState>(
            builder: (BuildContext context, TripPragueState state) {
              if (state.failure != null) {
                return ErrorScreen(
                  onRefresh: () => context.read<TripPragueBloc>().initialize(),
                  errorMessage:
                      ErrorMessageUtils.generate(context, state.failure),
                );
              } else {
                return Scaffold(
                  appBar: PreferredSize(
                    preferredSize:
                        Size.fromHeight(AppBar().preferredSize.height),
                    child: TripPragueAppBar(),
                  ),
                  body: SafeArea(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: Constant.mobileBreakpoint,
                        ),
                        child: child,
                      ),
                    ),
                  ),
                  bottomNavigationBar: const TripPragueNavBar(),
                );
              }
              // else {
              //   return LoadingScreen.scaffold();
              // }
            },
          ),
        ),
      );
}
