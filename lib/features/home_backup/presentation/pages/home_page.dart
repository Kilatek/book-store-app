import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badge;
import 'package:book_store/core/base/base_page.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/features/home/presentation/widgets/avatar_image.dart';
import 'package:book_store/features/home_backup/presentation/bloc/home_bloc.dart';
import 'package:book_store/features/home_backup/presentation/widgets/book_item.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  PageState createState() => PageState();
}

class PageState extends BasePageState<HomePage, HomeBloc> {
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
                    ))),
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
                indicatorColor: AppColors.black,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.black,
                ),
                labelPadding: const EdgeInsets.only(top: 8, bottom: 8),
                unselectedLabelColor: AppColors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  badge.Badge(
                    position: badge.BadgePosition.topEnd(top: -10, end: -20),
                    badgeContent: const Text(
                      '1',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: const Text(
                      "Books",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  badge.Badge(
                    position: badge.BadgePosition.topEnd(top: -10, end: -20),
                    badgeContent: const Text(
                      '2',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: const Text(
                      "Authors",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      children: getNewBooks()),
                  ListView(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      children: getPopularBooks()),
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

  getNewBooks() {
    return List.generate(
        latestBooks.length, (index) => BookItem(book: latestBooks[index]));
  }

  getPopularBooks() {
    return List.generate(
        popularBooks.length, (index) => BookItem(book: popularBooks[index]));
  }
}

var profile = "https://avatars.githubusercontent.com/u/86506519?v=4";

var latestBooks = [
  {
    "title": "The Creative Ideas",
    "image":
        "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/how-to-creative-ideas-book-cover-design-template-52f7ec58f53452b9b46a351cea1bd9a1_screen.jpg",
    "price": "\$58.99",
    "ori_price": "\$120.50"
  },
  {
    "title": "Follow Me to Ground",
    "image":
        "https://s26162.pcdn.co/wp-content/uploads/2019/12/46301955-668x1024.jpg",
    "price": "\$19.99",
    "ori_price": "\$120.50"
  },
  {
    "title": "Snow at Sunset",
    "image":
        "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/how-to-creative-ideas-book-cover-design-template-52f7ec58f53452b9b46a351cea1bd9a1_screen.jpg",
    "price": "\$29.90",
    "ori_price": "\$120.50"
  },
  {
    "title": "The Prince of Thorns",
    "image":
        "https://www.thecreativepenn.com/wp-content/uploads/2018/04/image1.jpeg",
    "price": "\$9.99",
    "ori_price": "\$120.50"
  },
  {
    "title": "The Last Breath",
    "image":
        "https://i.pinimg.com/originals/fc/52/3f/fc523fab7bcc161d8cca966ee974be64.png",
    "price": "\$93.90",
    "ori_price": "\$120.50"
  },
  {
    "title": "The Secrets",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwf6U8c_AwOwZvz9CjfMEzikpESGwcNqSuxQ&usqp=CAU",
    "price": "\$45.50",
    "ori_price": "\$120.50"
  }
];

var popularBooks = [
  {
    "title": "The Way of the Nameless",
    "image":
        "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/teal-and-orange-fantasy-book-cover-design-template-056106feb952bdfb7bfd16b4f9325c11.jpg",
    "price": "\$19.99",
    "ori_price": "\$40.00"
  },
  {
    "title": "The Power of You",
    "image":
        "https://i.pinimg.com/originals/97/c4/99/97c499de2581f8cca7f415b4d85870a5.jpg",
    "price": "\$9.99",
    "ori_price": "\$23.50"
  },
  {
    "title": "The Glow",
    "image":
        "https://i.pinimg.com/736x/4f/59/aa/4f59aaa78f898054f949351515875b3c--book-cover-design-book-design.jpg",
    "price": "\$26.50",
    "ori_price": "\$120.50"
  },
  {
    "title": "The Happy Morning",
    "image":
        "https://i.pinimg.com/736x/4f/59/aa/4f59aaa78f898054f949351515875b3c--book-cover-design-book-design.jpg",
    "price": "\$14.99",
    "ori_price": "\$120.50"
  },
  {
    "title": "Undersea World",
    "image":
        "https://www.edrawsoft.com/templates/images/seaworld-children-book-cover.png",
    "price": "\$29.99",
    "ori_price": "\$60.50"
  },
  {
    "title": "The Last Breath",
    "image":
        "https://www.ingramspark.com/hubfs/Book-Cover-Design-Pillar/32.png",
    "price": "\$9.99",
    "ori_price": "\$120.50"
  }
];
