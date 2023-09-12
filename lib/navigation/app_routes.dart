import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:book_store/features/auth/presentation/pages/auth_page.dart';
import 'package:book_store/features/auth/presentation/pages/splash_page.dart';
import 'package:book_store/features/home/presentation/pages/home_page.dart';
import 'package:book_store/features/home/presentation/pages/author_page.dart';
import 'package:book_store/features/home/presentation/pages/book_page.dart';

part 'app_routes.gr.dart';

enum PageType { add, update }

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
@LazySingleton()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AuthRoute.page,
        ),
        AutoRoute(
          page: HomeRoute.page,
        ),
        AutoRoute(
          initial: true,
          page: SplashRoute.page,
        ),
        AutoRoute(
          page: BookRoute.page,
        ),
        AutoRoute(
          page: AuthorRoute.page,
        ),
      ];
}
