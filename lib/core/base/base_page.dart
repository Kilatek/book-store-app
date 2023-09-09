import 'package:book_store/core/base/base_bloc.dart';
import 'package:book_store/core/base/common/common_bloc.dart';
import 'package:book_store/core/base/common/common_state.dart';
import 'package:book_store/core/error/error_listener_mixin.dart';
import 'package:book_store/core/error/handle_exception.dart';
import 'package:book_store/core/util/log_mixin.dart';
import 'package:book_store/di/di.dart';
import 'package:book_store/navigation/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class BasePageState<T extends StatefulWidget, B extends BaseBloc>
    extends BasePageStateDelegete<T, B> with ErrorListenerMixin {
  @override
  Widget buildPageListener({required Widget child}) {
    return BlocListener<CommonBloc, CommonState>(
      listenWhen: (previous, current) =>
          previous.appExceptionWrapper != current.appExceptionWrapper &&
          current.appExceptionWrapper != null,
      listener: (context, state) => handleException.handleException(
        state.appExceptionWrapper!,
        context,
        this,
      ),
      child: child,
    );
  }
}

abstract class BasePageStateDelegete<T extends StatefulWidget,
        B extends BaseBloc> extends State<T>
    with AutomaticKeepAliveClientMixin, LogMixin {
  late final AppNavigator navigator = getIt.get<AppNavigator>();
  late final HandleException handleException = HandleException();
  late final CommonBloc commonBloc = getIt.get<CommonBloc>();

  late final B bloc = getIt.get<B>()
    ..navigator = navigator
    ..commonBloc = commonBloc;

  bool isAppWidget = false;

  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Provider(
      create: (_) => navigator,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => bloc),
          BlocProvider(create: (_) => commonBloc),
        ],
        child: buildPageListener(
          child: isAppWidget
              ? buildPage(context)
              : Stack(
                  children: [
                    buildPage(context),
                    BlocBuilder<CommonBloc, CommonState>(
                      buildWhen: (previous, current) =>
                          previous.isLoading != current.isLoading,
                      builder: (context, state) => Visibility(
                        visible: state.isLoading,
                        child: buildPageLoading(),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildPageListener({required Widget child}) => child;

  Widget buildPage(BuildContext context);

  Widget buildPageLoading() => const Center(
        child: CircularProgressIndicator(),
      );
}
