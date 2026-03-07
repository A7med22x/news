import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/news/view_model/news_states.dart';
import 'package:news/shared/app_theme.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/news/data/models/news.dart';
import 'package:news/news/view/widgets/news_item.dart';
import 'package:news/news/view_model/news_view_model.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:news/shared/service_locator.dart';
import 'package:news/shared/widgets/custom_home_bottom_sheet.dart';
import 'package:news/shared/widgets/error_indicator.dart';
import 'package:news/shared/widgets/load_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const String routeName = '/search screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  NewsViewModel newsViewModel = ServiceLocator.newsViewModel;
  List<News> newsSearch = [];
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => newsViewModel,
      child: Scaffold(
        appBar: AppBar(title: Text(appLocalizations.search)),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<NewsViewModel, NewsState>(
            builder: (_, state) {
              return Column(
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
                          settingsProvider.isDark
                              ? AppTheme.white
                              : AppTheme.black,
                          .srcIn,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: onClearInputFiled,
                        icon: SvgPicture.asset(
                          'assets/icons/delete.svg',
                          width: 24,
                          height: 24,
                          fit: .scaleDown,
                          colorFilter: ColorFilter.mode(
                            settingsProvider.isDark
                                ? AppTheme.white
                                : AppTheme.black,
                            .srcIn,
                          ),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      onChangedInputFiled(value);
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
                        : BlocBuilder<NewsViewModel, NewsState>(
                            builder: (_, state) {
                              if (state is GetNewsLoading) {
                                return LoadIndicator();
                              } else if (state is GetNewsError) {
                                return ErrorIndicator(state.errorMessage);
                              } else if (state is GetNewsSuccess) {
                                newsSearch = state.news;
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
                                    separatorBuilder: (_, _) =>
                                        SizedBox(height: 16),
                                    itemCount: newsSearch.length,
                                  );
                                }
                              } else {
                                return SizedBox();
                              }
                            },
                          ),
                  ),
                ],
              );
            },
          ),
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

  void onChangedInputFiled(String query) {
    newsViewModel.getSearchNews(query);
    setState(() {});
  }

  void onClearInputFiled() {
    searchController.clear();
    newsSearch.clear();
    setState(() {});
  }
}
