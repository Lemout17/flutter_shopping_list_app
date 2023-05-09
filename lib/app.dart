import 'package:flutter/material.dart';
import 'package:flutter_shopping_list_app/pages/home_page.dart';
import 'package:flutter_shopping_list_app/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Groceries',
      theme: AppTheme.mainTheme,
      home: const HomePage(),
    );
  }
}
