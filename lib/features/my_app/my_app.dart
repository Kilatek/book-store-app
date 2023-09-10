import 'package:book_store/core/base/base_page.dart';
import 'package:book_store/core/theme/colors.dart';
import 'package:book_store/features/my_app/app_bloc.dart';
import 'package:book_store/navigation/app_routes.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends BasePageState<MyApp, AppBloc> {
  final _appRouter = GetIt.instance.get<AppRouter>();
  @override
  bool get isAppWidget => true;

  @override
  Widget buildPage(BuildContext context) {
    return MaterialApp.router(
      title: 'Book store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, primaryColor: primary),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
