import 'package:flutter/material.dart';
import 'package:news/shared/app_theme.dart';
import 'package:news/news/data/models/news.dart';
import 'package:news/news/view_model/news_view_model.dart';
import 'package:news/shared/service_locator.dart';
import 'package:news/sourses/data/models/source.dart';
import 'package:news/news/view/widgets/news_item.dart';
import 'package:news/sourses/view/widgets/tab_item.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:news/sourses/view_model/sources_states.dart';
import 'package:news/sourses/view_model/sources_view_model.dart';
import 'package:news/shared/widgets/custom_home_bottom_sheet.dart';
import 'package:news/shared/widgets/load_indicator.dart';
import 'package:news/shared/widgets/error_indicator.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {
  String categoryId;

  NewsView({required this.categoryId});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  SourcesViewModel sourcesViewModel = ServiceLocator.sourcesViewModel;
  NewsViewModel newsViewModel = ServiceLocator.newsViewModel;
  int currentIndex = 0;
  static const pageSize = 20;
  late PagingController<int, News> pagingController;
  List<Source> sources = [];

  @override
  void initState() {
    super.initState();
    sourcesViewModel.getSources(widget.categoryId);
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sourcesViewModel),
        BlocProvider(create: (_) => newsViewModel),
      ],
      child: BlocBuilder<SourcesViewModel, SourcesState>(
        builder: (_, state) {
          if (state is GetSourcesLoading) {
            return LoadIndicator();
          } else if (state is GetSourcesError) {
            return ErrorIndicator(state.errorMessage);
          } else if (state is GetSourcesSuccess) {
            sources = state.sources;
            pagingController = PagingController(
              getNextPageKey: (state) =>
                  state.lastPageIsEmpty ? null : state.nextIntPageKey,
              fetchPage: (pageKey) async {
                if (sources.isEmpty) return [];
                await newsViewModel.getNews(
                  sources[currentIndex].id!,
                  pageKey,
                  pageSize,
                );
                return newsViewModel.news;
              },
            );

            return Column(
              children: [
                DefaultTabController(
                  length: sources.length,
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: .start,
                    dividerColor: Colors.transparent,
                    indicatorColor: settingsProvider.isDark
                        ? AppTheme.white
                        : AppTheme.black,
                    tabs: sources
                        .map(
                          (source) => TabItem(
                            source: source,
                            isSelected: currentIndex == sources.indexOf(source),
                          ),
                        )
                        .toList(),
                    labelPadding: EdgeInsetsDirectional.only(start: 16),
                    onTap: (index) {
                      if (currentIndex == index) return;
                      currentIndex = index;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: PagingListener<int, News>(
                    controller: pagingController,
                    builder: (context, state, fetchNextPage) => PagedListView(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      builderDelegate: PagedChildBuilderDelegate<News>(
                        itemBuilder: (context, news, index) => InkWell(
                          onTap: () {
                            showBotomSheet(news);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: NewsItem(news),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return SizedBox();
          }
        },
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
