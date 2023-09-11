import 'package:book_store/core/base/base_bloc.dart';
import 'package:book_store/core/base/common/common_bloc.dart';
import 'package:book_store/core/base/common/common_state.dart';
import 'package:book_store/core/error/error_listener_mixin.dart';
import 'package:book_store/core/error/handle_exception.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/core/util/log_mixin.dart';
import 'package:book_store/core/util/stream/dispose_bag.dart';
import 'package:book_store/features/my_app/app_bloc.dart';
import 'package:book_store/navigation/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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
        this,
      ),
      child: child,
    );
  }
}

abstract class BasePageStateDelegete<T extends StatefulWidget,
    B extends BaseBloc> extends State<T> with LogMixin {
  late final AppNavigator navigator = GetIt.instance.get<AppNavigator>();
  late final AppBloc appBloc = GetIt.instance.get<AppBloc>();
  late final HandleException handleException = HandleException();
  late final CommonBloc commonBloc = GetIt.instance.get<CommonBloc>()
    ..navigator = navigator
    ..disposeBag = disposeBag
    ..appBloc = appBloc;

  late final B bloc = GetIt.instance.get<B>()
    ..navigator = navigator
    ..appBloc = appBloc
    ..disposeBag = disposeBag
    ..commonBloc = commonBloc;

  late final DisposeBag disposeBag = DisposeBag();

  bool isAppWidget = false;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => navigator,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<B>(create: (_) => bloc),
          BlocProvider<CommonBloc>(create: (_) => commonBloc),
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
        // child: CircularProgressIndicator(
        //   color: AppColors.black,
        // ),
      );

  @override
  void dispose() {
    super.dispose();
    disposeBag.dispose();
  }
}
