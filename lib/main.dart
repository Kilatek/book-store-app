import 'package:book_store/core/theme/colors.dart';
import 'package:book_store/features/home/presentation/pages/home_page.dart';

import 'injection_container.dart' as di;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, primaryColor: primary),
      // TODO: Handle check JWT to routing home page or login page
      home: HomePage(),
    );
  }
}
