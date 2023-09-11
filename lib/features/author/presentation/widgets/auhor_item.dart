import 'dart:math';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/features/author/presentation/pages/author_detail_page.dart';
import 'package:book_store/features/home_backup/domain/entities/author.dart';
import 'package:book_store/features/home_backup/presentation/widgets/avatar_image.dart';
import 'package:flutter/material.dart';

class AuthorItem extends StatelessWidget {
  const AuthorItem({
    Key? key,
    required this.author,
  }) : super(key: key);
  final Author author;

  @override
  Widget build(BuildContext context) {
    double width = 80, height = 80;
    final firstChar = author.firstName[0];
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AuthorDetailPage(author: author),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Container(
              width: width,
              height: height,
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                child: Text(firstChar,
                    style: const  TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${author.firstName} ${author.lastName}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: author.nationality,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextSpan(text: "   "),
                      TextSpan(
                        text: author.birthDate,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
