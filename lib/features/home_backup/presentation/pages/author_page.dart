import 'package:auto_route/auto_route.dart';
import 'package:book_store/core/base/base_page.dart';
import 'package:book_store/core/dimens/dimens.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/core/util/view_utils.dart';
import 'package:book_store/features/auth/presentation/widgets/round_button.dart';
import 'package:book_store/features/auth/presentation/widgets/round_textfield.dart';
import 'package:book_store/features/home_backup/presentation/bloc/home_bloc.dart';
import 'package:book_store/features/home_backup/presentation/bloc/home_event.dart';
import 'package:book_store/features/home_backup/presentation/bloc/home_state.dart';
import 'package:book_store/features/home_backup/presentation/widgets/date_picker.dart';
import 'package:book_store/navigation/app_routes.dart';
import 'package:book_store/navigation/popup/app_popup_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AuthorPage extends StatefulWidget {
  const AuthorPage({
    super.key,
    required this.id,
  });
  final String? id;

  @override
  State<AuthorPage> createState() => _PageState();
}

class _PageState extends BasePageState<AuthorPage, HomeBloc> {
  final _firstName = TextEditingController();
  final _lastname = TextEditingController();
  final _birthDate = TextEditingController();
  final _nationality = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    _firstName.addListener(() {
      bloc.add(HomeEvent.authorFirstNameChanged(_firstName.text));
    });
    _lastname.addListener(() {
      bloc.add(HomeEvent.authorLastNameChanged(_lastname.text));
    });
    _birthDate.addListener(() {
      bloc.add(HomeEvent.authorBirthDateChanged(_birthDate.text));
    });
    _nationality.addListener(() {
      bloc.add(HomeEvent.authorNationalityChanged(_nationality.text));
    });
    bloc.add(
      HomeEvent.authorInitial(
        widget.id != null ? PageType.update : PageType.add,
        widget.id ?? '',
      ),
    );
  }

  @override
  Widget buildPageListener({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) =>
              previous.pageType != current.pageType && current.pageType != null,
          listener: (context, state) {
            _firstName.text = state.authorFirstName.getOrElse(() => '');
            _lastname.text = state.authorLastName.getOrElse(() => '');
            _birthDate.text = state.authorBirthDate.getOrElse(() => '');
            _nationality.text = state.authorNationality.getOrElse(() => '');
          },
        ),
      ],
      child: child,
    );
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastname.dispose();
    _birthDate.dispose();
    _nationality.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    final pageType = widget.id != null ? PageType.update : PageType.add;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () => navigator.pop(),
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Image.asset(
              "assets/img/black_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          pageType == PageType.add ? 'Create Author' : 'Update Author',
          style: const TextStyle(
            color: AppColors.black,
            fontSize: Dimens.d20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if (widget.id != null)
            InkWell(
              onTap: () async {
                await navigator.showAdaptiveDialog(
                  appPopupInfo: AppPopupInfo.confirmDialog(
                    message: 'Are you sure you want to delete?',
                    title: 'Delete Author',
                    onPressed: Func0(() {
                      bloc.add(HomeEvent.deleteAuthorPressed(widget.id ?? ''));
                    }),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(
                  Dimens.d8,
                ),
                height: Dimens.d40,
                width: Dimens.d40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(
                    Dimens.d10,
                  ),
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            )
        ],
      ),
      body: GestureDetector(
        onTap: () => ViewUtils.hideKeyboard(context),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              height: media.height * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.d20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                      return RoundTextField(
                        validator: (_) => state.authorFirstName.fold(
                          (f) => f.message,
                          (r) => null,
                        ),
                        hitText: 'First Name',
                        icon: "assets/img/user_text.png",
                        controller: _firstName,
                      );
                    }),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                      return RoundTextField(
                        validator: (_) => state.authorLastName.fold(
                          (f) => f.message,
                          (r) => null,
                        ),
                        hitText: 'Last Name',
                        icon: "assets/img/user_text.png",
                        controller: _lastname,
                      );
                    }),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                      return RoundTextField(
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        validator: (_) => state.authorBirthDate.fold(
                          (f) => f.message,
                          (r) => null,
                        ),
                        hitText: 'Birth Date',
                        icon: "assets/img/time_workout.png",
                        controller: _birthDate,
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
                        validator: (_) => state.authorNationality.fold(
                          (f) => f.message,
                          (r) => null,
                        ),
                        hitText: 'Nationality',
                        icon: "assets/img/user_text.png",
                        controller: _nationality,
                      );
                    }),
                    SizedBox(
                      height: media.width * 0.02,
                    ),
                    const Spacer(),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        return RoundButton(
                          isLoading: state.isSubmitting,
                          title: 'Save',
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              pageType == PageType.add
                                  ? bloc.add(
                                      const HomeEvent.createAuthorPressed(),
                                    )
                                  : bloc.add(
                                      HomeEvent.updateAuthorPressed(
                                        widget.id ?? '',
                                      ),
                                    );
                            }
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

  Future<void> _selectDate(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return DatePicker(
          initialDate: selectedDate,
          onDateSelected: (newDate) {
            selectedDate = newDate;
            _birthDate.text = "${newDate.toLocal()}".split(' ')[0];
          },
        );
      },
    );
  }
}
