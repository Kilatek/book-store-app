import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:book_store/features/auth/presentation/pages/auth_page.dart';

part 'app_routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
@LazySingleton()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AuthRoute.page,
          initial: true,
        ),
      ];
}
