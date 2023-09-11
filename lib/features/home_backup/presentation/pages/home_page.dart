import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badge;
import 'package:book_store/core/base/base_page.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/features/author/presentation/pages/author_page.dart';
import 'package:book_store/features/author/presentation/widgets/add_author_dialog.dart';
import 'package:book_store/features/book/presentation/pages/book_page.dart';
import 'package:book_store/features/home_backup/presentation/bloc/home_bloc.dart';
import 'package:book_store/features/home_backup/presentation/bloc/home_state.dart';
import 'package:book_store/features/home_backup/presentation/widgets/avatar_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var profile = "https://avatars.githubusercontent.com/u/86506519?v=4";

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  PageState createState() => PageState();
}

class PageState extends BasePageState<HomePage, HomeBloc>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
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
              profile,
              isSVG: false,
              width: 27,
              height: 27,
            )
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
                controller: _tabController, // Make sure the controller is set

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
                controller: _tabController, // Make sure the controller is set

                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return BookPage(state.books);
                    },
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return AuthorPage(state.authors);
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
        onPressed: () {
          if (_tabController.index == 0) {
            // add book
          } else {
            // add user
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext _context) {
                return AddAuthorDialog(
                  onClose: () {},
                );
              },
            );
          }
        },
        tooltip: _tabController.index == 0 ? "Add book" : "Add author",
        child: const Icon(Icons.add),
      ),
    );
  }
}
