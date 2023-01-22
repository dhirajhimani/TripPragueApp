import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:trip_prague/app/constants/constant.dart';
import 'package:trip_prague/app/themes/spacing.dart';
import 'package:trip_prague/app/utils/dialog_utils.dart';
import 'package:trip_prague/app/utils/error_message_utils.dart';
import 'package:trip_prague/app/utils/extensions.dart';
import 'package:trip_prague/app/utils/injection.dart';
import 'package:trip_prague/core/domain/bloc/trip_prague/trip_prague_bloc.dart';
import 'package:trip_prague/core/presentation/widgets/app_title.dart';
import 'package:trip_prague/core/presentation/widgets/connectivity_checker.dart';
import 'package:trip_prague/core/presentation/widgets/trip_prague_button.dart';
import 'package:trip_prague/core/presentation/widgets/trip_prague_text_field.dart';
import 'package:trip_prague/features/auth/domain/bloc/login_bloc.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordTextController =
        useTextEditingController();
    final TextEditingController emailTextController =
        useTextEditingController();

    return BlocProvider<LoginBloc>(
      create: (BuildContext context) => getIt<LoginBloc>(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: _loginScreenListener,
        builder: (BuildContext context, LoginState state) {
          emailTextController
            ..value = TextEditingValue(text: state.emailAddress ?? '')
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: emailTextController.text.length),
            );

          return ConnectivityChecker.scaffold(
            body: Center(
              child: Container(
                constraints:
                    const BoxConstraints(maxWidth: Constant.mobileBreakpoint),
                padding: EdgeInsets.all(Insets.xl),
                child: Column(
                  children: <Widget>[
                    const Flexible(
                      child: Center(
                        child: AppTitle(),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          TripPragueTextField(
                            labelText: context.l10n.login__label_text__email,
                            controller: emailTextController,
                            autofocus: true,
                            hintText:
                                context.l10n.login__text_field_hint__email,
                            onChanged: (String value) => context
                                .read<LoginBloc>()
                                .onEmailAddressChanged(value),
                          ),
                          VSpace.lg,
                          TripPragueTextField(
                            labelText: context.l10n.login__label_text__password,
                            controller: passwordTextController,
                            isPassword: true,
                            textInputType: TextInputType.visiblePassword,
                            hintText:
                                context.l10n.login__text_field_hint__password,
                          ),
                          VSpace.xxl,
                          TripPragueButton(
                            isExpanded: true,
                            isEnabled: !state.isLoading,
                            onPressed: () => context.read<LoginBloc>().login(
                                  emailTextController.text,
                                  passwordTextController.text,
                                ),
                            text: context.l10n.login__button_text__login,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _loginScreenListener(BuildContext context, LoginState state) {
    if (state.isSuccess) {
      context.read<TripPragueBloc>().authenticate();
    } else if (state.failure != null) {
      DialogUtils.showSnackbar(
        context,
        ErrorMessageUtils.generate(context, state.failure),
      );
    }
  }
}
