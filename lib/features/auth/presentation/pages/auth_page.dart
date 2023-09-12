import 'package:auto_route/auto_route.dart';
import 'package:book_store/core/base/base_page.dart';
import 'package:book_store/core/dimens/dimens.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/core/util/view_utils.dart';
import 'package:book_store/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:book_store/features/auth/presentation/bloc/auth_event.dart';
import 'package:book_store/features/auth/presentation/bloc/auth_state.dart';
import 'package:book_store/features/auth/presentation/widgets/round_button.dart';
import 'package:book_store/features/auth/presentation/widgets/round_textfield.dart';
import 'package:book_store/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends BasePageState<AuthPage, AuthBloc> {
  final _emailControler = TextEditingController();
  final _passwordControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailControler.addListener(() {
      bloc.add(EmailChanged(_emailControler.text));
    });

    _passwordControler.addListener(() {
      bloc.add(PasswordChanged(_passwordControler.text));
    });
  }

  @override
  Widget buildPageListener({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) => current.user != null,
          listener: (context, state) {
            logD('user: ${state.user}');
            navigator.replace(const HomeRoute());
          },
        ),
      ],
      child: child,
    );
  }

  @override
  void dispose() {
    _emailControler.dispose();
    _passwordControler.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GestureDetector(
        onTap: () => ViewUtils.hideKeyboard(context),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              height: media.height * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.d20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hey there,',
                      style: TextStyle(
                        color: AppColors.gray,
                        fontSize: Dimens.d16,
                      ),
                    ),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: Dimens.d20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                      return RoundTextField(
                        validator: (_) => state.emailAddress.fold(
                          (f) => f.message,
                          (r) => null,
                        ),
                        hitText: 'Email',
                        icon: "assets/img/email.png",
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailControler,
                      );
                    }),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                      return RoundTextField(
                        validator: (_) => state.password.fold(
                          (f) => f.message,
                          (r) => null,
                        ),
                        hitText: 'Password',
                        icon: "assets/img/lock.png",
                        obscureText: !state.isShowPassword,
                        controller: _passwordControler,
                        rigtIcon: TextButton(
                          onPressed: () {
                            bloc.add(const AuthEvent.showHidePasswordToggle());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: Dimens.d20,
                            height: Dimens.d20,
                            child: Image.asset(
                              state.isShowPassword
                                  ? "assets/img/show_password.png"
                                  : "assets/img/hide_password.png",
                              width: Dimens.d20,
                              height: Dimens.d20,
                              fit: BoxFit.contain,
                              color: AppColors.gray,
                            ),
                          ),
                        ),
                      );
                    }),
                    const Spacer(),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return RoundButton(
                          isLoading: state.isSubmitting,
                          title: 'Login',
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              bloc.add(
                                const SignInWithEmailAndPasswordPressed(),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
