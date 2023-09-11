import 'package:auto_route/auto_route.dart';
import 'package:book_store/core/base/base_page.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:book_store/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _AuthPageState();
}

class _AuthPageState extends BasePageState<SplashPage, AuthBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const AuthEvent.initial());
  }

  @override
  Widget buildPage(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset(
          'assets/img/logo.jpg',
          width: media.width * 0.5,
        ),
      ),
    );
  }
}
