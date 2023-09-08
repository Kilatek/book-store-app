import 'package:book_store/core/theme/colors.dart';
import 'package:flutter/material.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({Key? key}) : super(key: key);

  @override
  _AuthorPageState createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: appBgColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Authors',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ))),
              const Icon(
                Icons.search_rounded,
                color: primary,
              ),
            ],
          ),
        ),
        body: Container(
          child: Text('Author'),
        ));
  }
}
