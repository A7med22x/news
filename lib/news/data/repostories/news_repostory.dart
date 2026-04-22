import 'package:news/news/data/data_sources/news_data_sources.dart';
import 'package:news/news/data/models/news.dart';

class NewsRepostory {
  NewsDataSources dataSources;

  NewsRepostory(this.dataSources);

  Future<List<News>> getNews(String sourceId, int page) async {
    return dataSources.getNews(sourceId: sourceId, page: page);
  }

  Future<List<News>> getSearchNews(
    String query, {
    required int page,
  }) async {
    return dataSources.getSerachNews(query: query, page: page);
  }
}
