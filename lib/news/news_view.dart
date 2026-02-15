import 'package:flutter/material.dart';
import 'package:news/api/api_service.dart';
import 'package:news/app_theme.dart';
import 'package:news/models/news_response/news.dart';
import 'package:news/models/sources_response/source.dart';
import 'package:news/models/sources_response/sources_response.dart';
import 'package:news/news/news_item.dart';
import 'package:news/news/tab_item.dart';
import 'package:news/providers/settings_provider.dart';
import 'package:news/widgets/load_indicator.dart';
import 'package:news/widgets/error_indicator.dart';
import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {
  String categoryId;

  NewsView({required this.categoryId});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  late Future<SourcesResponse> getSourcesFuture = ApiService.getSources(
    widget.categoryId,
  );

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return FutureBuilder(
      future: getSourcesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == .waiting) {
          return LoadIndicator();
        } else if (snapshot.hasError || snapshot.data?.status != 'ok') {
          return ErrorIndicator();
        } else {
          List<Source> sources = snapshot.data?.sources ?? [];
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
                child: FutureBuilder(
                  future: ApiService.getNews(sources[currentIndex].id!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == .waiting) {
                      return LoadIndicator();
                    } else if (snapshot.hasError ||
                        snapshot.data?.status != 'ok') {
                      return ErrorIndicator();
                    } else {
                      List<News> news = snapshot.data?.news ?? [];
                      return ListView.separated(
                        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                        itemBuilder: (_, index) => NewsItem(news[index]),
                        separatorBuilder: (_, _) => SizedBox(height: 16),
                        itemCount: news.length,
                      );
                    }
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
