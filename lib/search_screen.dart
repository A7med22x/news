import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/app_theme.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/models/category_model.dart';
import 'package:news/news/news_item.dart';
import 'package:news/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const String routeName = '/search screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late CategoryModel selectedCategory;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    selectedCategory =
        ModalRoute.of(context)!.settings.arguments as CategoryModel;

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.search)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextFormField(
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(decoration: .none),
              decoration: InputDecoration(
                hintText: appLocalizations.search,
                prefixIcon: SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 24,
                  height: 24,
                  fit: .scaleDown,
                  colorFilter: ColorFilter.mode(
                    settingsProvider.isDark ? AppTheme.white : AppTheme.black,
                    .srcIn,
                  ),
                ),
                suffixIcon: SvgPicture.asset(
                  'assets/icons/delete.svg',
                  width: 24,
                  height: 24,
                  fit: .scaleDown,
                  colorFilter: ColorFilter.mode(
                    settingsProvider.isDark ? AppTheme.white : AppTheme.black,
                    .srcIn,
                  ),
                ),
              ),
              onChanged: (value) {},
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
            // Expanded(
            //   child: ListView.separated(
            //     padding: EdgeInsets.only(top: 16),
            //     itemBuilder: (_, index) => NewsItem(),
            //     separatorBuilder: (_, _) => SizedBox(height: 16),
            //     itemCount: 10,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
