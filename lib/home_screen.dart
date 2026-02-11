import 'package:flutter/material.dart';
import 'package:news/categories/categories_view.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/news/news_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home screen';

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.home)),
      body: NewsView(),
    );
  }
}
