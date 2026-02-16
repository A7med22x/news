import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/api/api_service.dart';
import 'package:news/app_theme.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/models/news_response/news.dart';
import 'package:news/models/search_response/search_response.dart';
import 'package:news/news/news_item.dart';
import 'package:news/providers/settings_provider.dart';
import 'package:news/widgets/custom_home_bottom_sheet.dart';
import 'package:news/widgets/error_indicator.dart';
import 'package:news/widgets/load_indicator.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const String routeName = '/search screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<SearchResponse>? getSearch;
  List<News> newsSearch = [];
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.search)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
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
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      searchController.clear();
                      getSearch = null;
                      newsSearch.clear();
                    });
                  },
                  icon: SvgPicture.asset(
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
              ),
              onChanged: (value) {
                getSearch = ApiService.getSerachNews(value);
                setState(() {});
              },
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
            Expanded(
              child: searchController.text.isEmpty
                  ? Center(
                      child: Text(
                        appLocalizations.typeWordToSearch,
                        style: textTheme.titleLarge,
                      ),
                    )
                  : FutureBuilder(
                      future: getSearch,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == .waiting) {
                          return LoadIndicator();
                        } else if (snapshot.hasError ||
                            snapshot.data?.status != 'ok') {
                          return ErrorIndicator();
                        } else {
                          newsSearch = snapshot.data?.news ?? [];

                          if (newsSearch.isEmpty) {
                            return Center(
                              child: Text(
                                appLocalizations.noResult,
                                style: textTheme.titleLarge,
                              ),
                            );
                          } else {
                            return ListView.separated(
                              padding: EdgeInsets.only(top: 16),
                              itemBuilder: (_, index) => InkWell(
                                onTap: () {
                                  showBotomSheet(newsSearch[index]);
                                },
                                child: NewsItem(newsSearch[index]),
                              ),
                              separatorBuilder: (_, _) => SizedBox(height: 16),
                              itemCount: newsSearch.length,
                            );
                          }
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void showBotomSheet(News news) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => CustomHomeBottomSheet(news),
    );
  }
}
