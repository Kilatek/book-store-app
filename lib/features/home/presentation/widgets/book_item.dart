import 'dart:math';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/features/home/presentation/widgets/avatar_image.dart';
import 'package:book_store/features/home/domain/entities/book.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  const BookItem({
    Key? key,
    required this.book,
  }) : super(key: key);
  final Book book;

  @override
  Widget build(BuildContext context) {
    double width = 80, height = 110;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Stack(children: [
            Container(
                padding: const EdgeInsets.only(bottom: 50, right: 40),
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowColor.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(1, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  width: width / 2,
                  height: height / 2,
                  decoration: BoxDecoration(
                      color:
                          Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15))),
                )),
            Container(
              width: width,
              height: height,
              padding: const EdgeInsets.all(8),
              child: AvatarImage(
                book.image,
                isSVG: false,
                radius: 8,
              ),
            )
          ]),
          const SizedBox(
            width: 18,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.name,
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
                        text: "${book.price}\$",
                        style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500)),
                    const TextSpan(text: "   "),
                    TextSpan(
                      text: book.author.firstName,
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
    );
  }
}
