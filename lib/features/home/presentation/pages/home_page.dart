import 'package:book_store/core/theme/colors.dart';
import 'package:book_store/features/author/presentation/pages/author_page.dart';
import 'package:book_store/features/book/presentation/pages/book_page.dart';
import 'package:book_store/features/home/presentation/bloc/tab_navigation_cubit.dart';
import 'package:book_store/features/home/presentation/widgets/bottombar_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TabNavigationCubit(),
      child: BlocBuilder<TabNavigationCubit, int>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBgColor,
            bottomNavigationBar: Container(
              height: 65,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
                color: bottomBarColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                child: BlocBuilder<TabNavigationCubit, int>(
                  builder: (context, tabIndex) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<TabNavigationCubit>().navigate(0);
                          },
                          child: badges.Badge(
                            position:
                                badges.BadgePosition.topEnd(top: -10, end: -10),
                            badgeContent: const Text(
                              '2',
                              style: TextStyle(color: Colors.white),
                            ),
                            child: BottomBarItem(
                              Icons.home,
                              "",
                              isActive: tabIndex == 0,
                              activeColor: secondary,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<TabNavigationCubit>().navigate(1);
                          },
                          child: badges.Badge(
                            position:
                                badges.BadgePosition.topEnd(top: -10, end: -10),
                            badgeContent: const Text(
                              '1',
                              style: TextStyle(color: Colors.white),
                            ),
                            child: BottomBarItem(
                              Icons.my_library_books_rounded,
                              "",
                              isActive: tabIndex == 1,
                              activeColor: secondary,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            body: BlocBuilder<TabNavigationCubit, int>(
              builder: (context, tabIndex) => getPage(tabIndex),
            ),
          );
        },
      ),
    );
  }

  getPage(int index) {
    return Container(
      decoration: const BoxDecoration(color: bottomBarColor),
      child: Container(
        decoration: const BoxDecoration(
          color: appBgColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(80),
          ),
        ),
        child: IndexedStack(
          index: index,
          children: const <Widget>[
            BookPage(),
            AuthorPage(),
          ],
        ),
      ),
    );
  }
}
