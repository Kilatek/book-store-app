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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  PageState createState() => PageState();
}

class PageState extends BasePageState<HomePage, HomeBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const HomeEvent.initial());
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
              onPressed: () {
                commonBloc.add(const ForceLogoutButtonPressed());
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.black,
        onPressed: () {},
        tooltip: 'Toggle',
        child: const Icon(Icons.add),
      ),
    );
  }

  getNewBooks(List<Book> books) {
    return List.generate(
      books.length,
      (index) => BookItem(
        book: books[index],
      ),
    );
  }

  getPopularBooks(List<Author> authors) {
    return List.generate(
      authors.length,
      (index) => AuthorItem(
        author: authors[index],
      ),
    );
  }
}
