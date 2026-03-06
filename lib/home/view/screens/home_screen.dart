import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/shared/app_theme.dart';
import 'package:news/categories/view/widgets/categories_view.dart';
import 'package:news/home/view/widgets/home_drawer.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/categories/data/models/category_model.dart';
import 'package:news/news/view/widgets/news_view.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:news/search/view/screens/search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedCategory == null
              ? appLocalizations.home
              : selectedCategory!.name,
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 16),
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamed(SearchScreen.routeName, arguments: selectedCategory);
            },
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              colorFilter: ColorFilter.mode(
                settingsProvider.isDark ? AppTheme.white : AppTheme.black,
                .srcIn,
              ),
            ),
          ),
        ],
      ),
      drawer: HomeDrawer(onGoToHomeCliced: resetSelectedCategory),
      body: selectedCategory == null
          ? CategoriesView(onCategorySelected: onCategorySelected)
          : NewsView(categoryId: selectedCategory!.id),
    );
  }

  void onCategorySelected(CategoryModel category) {
    selectedCategory = category;
    setState(() {});
  }

  void resetSelectedCategory() {
    if (selectedCategory == null) return;
    selectedCategory = null;
    setState(() {});
  }
}
