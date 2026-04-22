import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news/news/view_model/news_states.dart';
import 'package:news/shared/app_theme.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/news/data/models/news.dart';
import 'package:news/news/view/widgets/news_item.dart';
import 'package:news/news/view_model/news_view_model.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:news/shared/service_locator.dart';
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
  late PagingController<int, News> pagingController;

  @override
  void initState() {
    pagingController = PagingController(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (pageKey) async {
        await newsViewModel.getSearchNews(searchController.text, page: pageKey);
        return newsViewModel.searchNews;
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    pagingController.dispose();
    super.dispose();
  }

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
                      prefixIcon: InkWell(
                        onTap: () {
                          onChangedInputFiled(searchController.text);
                        },
                        child: SvgPicture.asset(
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
                    onFieldSubmitted: (value) {
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
                        : PagingListener<int, News>(
                            controller: pagingController,
                            builder: (context, state, fetchNextPage) =>
                                PagedListView(
                                  state: state,
                                  fetchNextPage: fetchNextPage,
                                  builderDelegate:
                                      PagedChildBuilderDelegate<News>(
                                        itemBuilder: (context, news, index) =>
                                            Padding(
                                              padding: EdgeInsets.all(16),
                                              child: NewsItem(news: news),
                                            ),
                                      ),
                                ),
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

  void onChangedInputFiled(String query) {
    pagingController.refresh();
    setState(() {});
  }

  void onClearInputFiled() {
    searchController.clear();
    newsSearch.clear();
    setState(() {});
  }
}
