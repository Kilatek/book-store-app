import 'package:auto_route/auto_route.dart';
import 'package:book_store/core/base/base_page.dart';
import 'package:book_store/core/dimens/dimens.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/core/util/view_utils.dart';
import 'package:book_store/features/auth/presentation/widgets/round_button.dart';
import 'package:book_store/features/auth/presentation/widgets/round_textfield.dart';
import 'package:book_store/features/home_backup/presentation/bloc/home_bloc.dart';
import 'package:book_store/features/home_backup/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => _PageState();
}

class _PageState extends BasePageState<BookPage, HomeBloc> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _publicationDate = TextEditingController();
  final _price = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _name.addListener(() {});
    _description.addListener(() {});
    _publicationDate.addListener(() {});
    _price.addListener(() {});
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _publicationDate.dispose();
    _price.dispose();
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
                    const Text(
                      'Create Book',
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
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                      return RoundTextField(
                        // validator: (_) => state.emailAddress.fold(
                        //   (f) => f.message,
                        //   (r) => null,
                        // ),
                        hitText: 'Name',
                        icon: "assets/img/user_text.png",
                        keyboardType: TextInputType.emailAddress,
                        controller: _name,
                      );
                    }),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                      return RoundTextField(
                        // validator: (_) => state.password.fold(
                        //   (f) => f.message,
                        //   (r) => null,
                        // ),
                        hitText: 'Description',
                        icon: "assets/img/user_text.png",
                        controller: _description,
                      );
                    }),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                      return RoundTextField(
                        // validator: (_) => state.password.fold(
                        //   (f) => f.message,
                        //   (r) => null,
                        // ),
                        hitText: 'Publication Date',
                        icon: "assets/img/time_workout.png",
                        controller: _publicationDate,
                        rigtIcon: TextButton(
                          onPressed: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: Dimens.d20,
                            height: Dimens.d20,
                            child: Image.asset(
                              "assets/img/time.png",
                              width: Dimens.d20,
                              height: Dimens.d20,
                              fit: BoxFit.contain,
                              color: AppColors.gray,
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                      return RoundTextField(
                        // validator: (_) => state.password.fold(
                        //   (f) => f.message,
                        //   (r) => null,
                        // ),
                        hitText: 'Price',
                        icon: "assets/img/user_text.png",
                        keyboardType: TextInputType.number,
                        controller: _price,
                        rigtIcon: Container(
                          alignment: Alignment.center,
                          width: Dimens.d20,
                          height: Dimens.d20,
                          child: Text(
                            '\$',
                            style: TextStyle(
                              color: AppColors.gray,
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                      return RoundTextField(
                        hitText: 'Author',
                        icon: "assets/img/user_text.png",
                        rigtIcon: TextButton(
                          onPressed: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: Dimens.d20,
                            height: Dimens.d20,
                            child: Image.asset(
                              "assets/img/p_down.png",
                              width: Dimens.d20,
                              height: Dimens.d20,
                              fit: BoxFit.contain,
                              color: AppColors.gray,
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: media.width * 0.02,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       'Forgot your password?',
                    //       style: TextStyle(
                    //         color: AppColors.gray,
                    //         fontSize: Dimens.d10,
                    //         decoration: TextDecoration.underline,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const Spacer(),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        return RoundButton(
                          // isLoading: state.isSubmitting,
                          title: 'Save',
                          onPressed: () {
                            // if (_formKey.currentState?.validate() == true) {
                            //   bloc.add(
                            //     const SignInWithEmailAndPasswordPressed(),
                            //   );
                            // }
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: media.width * 0.04,
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
