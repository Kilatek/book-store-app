import 'package:auto_route/auto_route.dart';
import 'package:book_store/core/base/base_page.dart';
import 'package:book_store/core/util/view_utils.dart';
import 'package:book_store/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends BasePageState<AuthPage, AuthBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return GestureDetector(
      onTap: () => ViewUtils.hideKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign In"),
        ),
      ),
    );
  }
}
