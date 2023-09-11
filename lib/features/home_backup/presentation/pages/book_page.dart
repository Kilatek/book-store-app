import 'package:auto_route/auto_route.dart';
import 'package:book_store/core/base/base_page.dart';
import 'package:book_store/core/dimens/dimens.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/core/util/view_utils.dart';
import 'package:book_store/features/auth/presentation/widgets/round_button.dart';
import 'package:book_store/features/auth/presentation/widgets/round_dropdown.dart';
import 'package:book_store/features/auth/presentation/widgets/round_textfield.dart';
import 'package:book_store/features/home_backup/presentation/bloc/home_bloc.dart';
import 'package:book_store/features/home_backup/presentation/bloc/home_event.dart';
import 'package:book_store/features/home_backup/presentation/bloc/home_state.dart';
import 'package:book_store/features/home_backup/presentation/widgets/date_picker.dart';
import 'package:book_store/navigation/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_store/navigation/popup/app_popup_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class BookPage extends StatefulWidget {
  const BookPage({
    super.key,
    required this.id,
  });
  final String? id;

  @override
  State<BookPage> createState() => _PageState();
}

class _PageState extends BasePageState<BookPage, HomeBloc> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _publicationDate = TextEditingController();
  final _price = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _name.addListener(() {
      bloc.add(HomeEvent.bookNameChanged(_name.text));
    });
    _description.addListener(() {
      bloc.add(HomeEvent.bookDescriptionChanged(_description.text));
    });
    _publicationDate.addListener(() {
      bloc.add(HomeEvent.bookPublicationDateChanged(_publicationDate.text));
    });
    _price.addListener(() {
      bloc.add(HomeEvent.bookPriceChanged(_price.text));
    });
    bloc.add(
      HomeEvent.bookInitial(
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
            _name.text = state.bookName.getOrElse(() => '');
            _description.text = state.bookDescription.getOrElse(() => '');
            _publicationDate.text =
                state.bookPublicationDate.getOrElse(() => '');
            _price.text = state.bookPrice.getOrElse(() => '');
          },
        ),
      ],
      child: child,
    );
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
          pageType == PageType.add ? 'Create Book' : 'Update Book',
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
                    title: 'Delete Book',
                    onPressed: Func0(() {
                      bloc.add(HomeEvent.deleteBookPressed(widget.id ?? ''));
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
                  Icons.close,
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
                        validator: (_) => state.bookName.fold(
                          (f) => f.message,
                          (r) => null,
                        ),
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
                        validator: (_) => state.bookDescription.fold(
                          (f) => f.message,
                          (r) => null,
                        ),
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
                        onTap: () => _selectDate(context),
                        readOnly: true,
                        validator: (_) => state.bookPublicationDate.fold(
                          (f) => f.message,
                          (r) => null,
                        ),
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
                        validator: (_) => state.bookPrice.fold(
                          (f) => f.message,
                          (r) => null,
                        ),
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
                    BlocBuilder<HomeBloc, HomeState>(
                        buildWhen: (previous, current) =>
                            previous.authors != current.authors &&
                                current.authors.isNotEmpty ||
                            current.bookAuthor != null,
                        builder: (context, state) {
                          final items = state.authors
                              .map((e) =>
                                  '${e.firstName} ${e.lastName} - ${e.birthDate}')
                              .toList();
                          if (items.isEmpty) return Container();
                          String initilalValue = items.first;
                          if (state.bookAuthor != null) {
                            initilalValue =
                                '${state.bookAuthor?.firstName} ${state.bookAuthor?.lastName} - ${state.bookAuthor?.birthDate}';
                          }

                          return RoundDropDown(
                            value: initilalValue,
                            hitText: 'Author',
                            icon: "assets/img/user_text.png",
                            items: items,
                            onChanged: (value) {
                              final (_, index) = value;
                              bloc.add(
                                HomeEvent.bookAuthorChanged(
                                  state.authors[index],
                                ),
                              );
                            },
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
                                      const HomeEvent.createBookPressed(),
                                    )
                                  : bloc.add(
                                      HomeEvent.updateBookPressed(
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
          onDateSelected: (selectedDate) {
            selectedDate = selectedDate;
            _publicationDate.text = "${selectedDate.toLocal()}".split(' ')[0];
          },
        );
      },
    );
  }
}
