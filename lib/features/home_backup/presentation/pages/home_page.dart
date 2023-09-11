import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badge;
import 'package:book_store/core/base/base_page.dart';
import 'package:book_store/core/base/common/common_event.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/features/home/presentation/widgets/avatar_image.dart';
import 'package:book_store/features/home_backup/domain/entities/author.dart';
import 'package:book_store/features/home_backup/domain/entities/book.dart';
import 'package:book_store/features/home_backup/presentation/bloc/home_bloc.dart';
import 'package:book_store/features/home_backup/presentation/bloc/home_event.dart';
import 'package:book_store/features/home_backup/presentation/bloc/home_state.dart';
import 'package:book_store/features/home_backup/presentation/widgets/auhor_item.dart';
import 'package:book_store/features/home_backup/presentation/widgets/book_item.dart';
import 'package:book_store/navigation/app_routes.dart';
import 'package:book_store/navigation/popup/app_popup_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  PageState createState() => PageState();
}

class PageState extends BasePageState<HomePage, HomeBloc>
    with TickerProviderStateMixin {
  late TabController tabControler;
  final _key = GlobalKey<ExpandableFabState>();
  @override
  void initState() {
    super.initState();
    tabControler = TabController(length: 2, vsync: this);
    tabControler.addListener(() {
      // bloc.add(HomeEvent.tabChanged(tabControler.index));
    });
    bloc.add(const HomeEvent.initial());
  }

  @override
  void dispose() {
    tabControler.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return body();
  }

  Widget body() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appBgColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Icon(
                  Icons.vertical_distribute_rounded,
                  color: AppColors.black,
                ),
              ),
            ),
            const Icon(
              Icons.search_rounded,
              color: AppColors.black,
            ),
            const SizedBox(
              width: 15,
            ),
            AvatarImage(
              "https://i.pravatar.cc/300?img=${Random().nextInt(10)}",
              isSVG: false,
              width: 27,
              height: 27,
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: () async {
                await navigator.showAdaptiveDialog(
                  appPopupInfo: AppPopupInfo.confirmDialog(
                    message: 'Are you sure you want to logout?',
                    title: 'Logout',
                    onPressed: Func0(() {
                      commonBloc.add(const ForceLogoutButtonPressed());
                    }),
                  ),
                );
              },
              icon: const Icon(
                Icons.logout,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 10,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
              child: TabBar(
                controller: tabControler,
                indicatorColor: AppColors.black,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.black,
                ),
                labelPadding: const EdgeInsets.only(top: 8, bottom: 8),
                unselectedLabelColor: AppColors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return badge.Badge(
                        position:
                            badge.BadgePosition.topEnd(top: -10, end: -20),
                        badgeContent: Text(
                          state.books.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        child: const Text(
                          "Books",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return badge.Badge(
                        position:
                            badge.BadgePosition.topEnd(top: -10, end: -20),
                        badgeContent: Text(
                          state.authors.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        child: const Text(
                          "Authors",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabControler,
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          bloc.add(const HomeEvent.updateBooks());
                        },
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          children: getNewBooks(state.books),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          bloc.add(const HomeEvent.updateAuthors());
                        },
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          children: getPopularBooks(state.authors),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        // duration: const Duration(milliseconds: 500),
        // distance: 200.0,
        type: ExpandableFabType.up,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.add),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          shape: const CircleBorder(),
        ),
        closeButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: const Icon(Icons.close),
          fabSize: ExpandableFabSize.small,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          shape: const CircleBorder(),
        ),
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.black.withOpacity(0.5),
        ),
        children: [
          Column(
            children: [
              FloatingActionButton.small(
                tooltip: 'Author',
                heroTag: null,
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                onPressed: () {
                  final state = _key.currentState;
                  if (state != null) {
                    debugPrint('isOpen:${state.isOpen}');
                    state.toggle();
                  }
                  bloc.add(const HomeEvent.tabChanged(1));
                  bloc.add(const HomeEvent.createPressed());
                },
                child: const Icon(Icons.person),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Create Author",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          Column(
            children: [
              FloatingActionButton.small(
                tooltip: 'Book',
                heroTag: null,
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                onPressed: () {
                  final state = _key.currentState;
                  if (state != null) {
                    debugPrint('isOpen:${state.isOpen}');
                    state.toggle();
                  }
                  bloc.add(const HomeEvent.tabChanged(0));
                  bloc.add(const HomeEvent.createPressed());
                },
                child: const Icon(Icons.store),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Create Book",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ],
      ),
      //   floatingActionButton: FloatingActionButton(
      //     backgroundColor: AppColors.black,
      //     onPressed: () {
      //       bloc.add(const HomeEvent.createPressed());
      //     },
      //     tooltip: 'Toggle',
      //     child: const Icon(Icons.add),
      //   ),
    );
  }

  getNewBooks(List<Book> books) {
    return List.generate(
      books.length,
      (index) => InkWell(
        onTap: () async {
          await navigator.push(BookRoute(id: books[index].id));
          bloc.add(const HomeEvent.updateBooks());
        },
        child: BookItem(
          book: books[index],
        ),
      ),
    );
  }

  getPopularBooks(List<Author> authors) {
    return List.generate(
      authors.length,
      (index) => InkWell(
        onTap: () async {
          await navigator.push(AuthorRoute(id: authors[index].id));
          bloc.add(const HomeEvent.updateAuthors());
        },
        child: AuthorItem(
          author: authors[index],
        ),
      ),
    );
  }
}
