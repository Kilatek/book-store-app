import 'package:auto_route/auto_route.dart';
import 'package:book_store/core/util/log_mixin.dart';
import 'package:book_store/core/util/view_utils.dart';
import 'package:book_store/navigation/app_routes.dart';
import 'package:book_store/navigation/popup/app_popup_info.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

@LazySingleton()
class AppNavigator with LogMixin {
  AppNavigator(this.appRouter);

  final AppRouter appRouter;

  final tabsRoutes = const [];

  final _popups = <AppPopupInfo>{};

  TabsRouter? tabsRouter;

  StackRouter? get _currentTabRouter =>
      tabsRouter?.stackRouterOfIndex(tabsRouter?.activeIndex ?? 0);

  StackRouter get _currentTabRouterOrRootRouter =>
      _currentTabRouter ?? appRouter;
  BuildContext? get _currentTabRouterContext =>
      _currentTabRouter?.navigatorKey.currentContext;
  BuildContext get _currentTabContextOrRootContext =>
      _currentTabRouterContext ?? _rootRouterContext;

  bool get canPopSelfOrChildren => appRouter.canPop();

  BuildContext get _rootRouterContext => appRouter.navigatorKey.currentContext!;

  void popUntilRootOfCurrentTab() {
    if (tabsRouter == null) {
      throw 'Not found any TabRouter';
    }

    if (_currentTabRouter?.canPop() == true) {
      _currentTabRouter?.popUntilRoot();
    }
  }

  Future<T?> push<T extends Object?>(PageRouteInfo pageRouteInfo) {
    return appRouter.push<T>(pageRouteInfo);
  }

  Future<void> pushAll(List<PageRouteInfo> listPageRouteInfo) {
    return appRouter.pushAll(listPageRouteInfo);
  }

  Future<T?> replace<T extends Object?>(PageRouteInfo pageRouteInfo) {
    return appRouter.replace<T>(pageRouteInfo);
  }

  Future<void> replaceAll(List<PageRouteInfo> listPageRouteInfo) {
    return appRouter.replaceAll(listPageRouteInfo);
  }

  Future<bool> pop<T extends Object?>(
      {T? result, bool useRootNavigator = false}) {
    return useRootNavigator
        ? appRouter.pop<T>(result)
        : _currentTabRouterOrRootRouter.pop<T>(result);
  }

  Future<T?> popAndPush<T extends Object?, R extends Object?>(
    PageRouteInfo pageRouteInfo, {
    R? result,
    bool useRootNavigator = false,
  }) {
    return useRootNavigator
        ? appRouter.popAndPush<T, R>(pageRouteInfo, result: result)
        : _currentTabRouterOrRootRouter.popAndPush<T, R>(
            pageRouteInfo,
            result: result,
          );
  }

  void popUntilRoot({bool useRootNavigator = false}) {
    useRootNavigator
        ? appRouter.popUntilRoot()
        : _currentTabRouterOrRootRouter.popUntilRoot();
  }

  void popUntilRouteName(String routeName) {
    appRouter.popUntilRouteWithName(routeName);
  }

  bool removeUntilRouteName(String routeName) {
    return appRouter.removeUntil((route) => route.name == routeName);
  }

  bool removeAllRoutesWithName(String routeName) {
    return appRouter.removeWhere((route) => route.name == routeName);
  }

  Future<void> popAndPushAll(List<PageRouteInfo> listPageRouteInfo) {
    return appRouter.popAndPushAll(listPageRouteInfo);
  }

  bool removeLast() {
    return appRouter.removeLast();
  }

  Future<T?> showAdaptiveDialog<T extends Object?>({
    required AppPopupInfo appPopupInfo,
    Duration transitionDuration = const Duration(milliseconds: 200),
    Widget Function(
      BuildContext,
      Animation<double>,
      Animation<double>,
      Widget,
    )? transitionBuilder,
    Color barrierColor = const Color(0x80000000),
    bool barrierDismissible = false,
    bool useRootNavigator = true,
  }) async {
    if (_popups.contains(appPopupInfo)) {
      logD('Dialog $appPopupInfo already shown');

      return Future.value(null);
    }
    _popups.add(appPopupInfo);
    final dialog = await showGeneralDialog<T>(
      context: useRootNavigator
          ? _rootRouterContext
          : _currentTabContextOrRootContext,
      barrierColor: barrierColor,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation1,
        Animation<double> animation2,
      ) =>
          WillPopScope(
        onWillPop: () async {
          logD('Dialog $appPopupInfo dismissed');
          _popups.remove(appPopupInfo);

          return Future.value(true);
        },
        child: AlertDialog.adaptive(
          actions: [
            TextButton(
              onPressed: () {
                pop();
                appPopupInfo.onPressed?.call();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => pop(),
              child: const Text('No'),
            ),
          ],
          title: Text(appPopupInfo.title),
          content: Text(appPopupInfo.message),
        ),
      ),
      transitionBuilder: transitionBuilder,
      transitionDuration: transitionDuration,
    );
    return dialog;
  }

  void showErrorSnackBar({required String message, Duration? duration}) {
    ViewUtils.showAppSnackBar(
      _rootRouterContext,
      message,
      duration: duration,
      backgroundColor: Colors.red,
    );
  }

  void showSuccessSnackBar({required String message, Duration? duration}) {
    ViewUtils.showAppSnackBar(
      _rootRouterContext,
      message,
      duration: duration,
      backgroundColor: Colors.green,
    );
  }
}
