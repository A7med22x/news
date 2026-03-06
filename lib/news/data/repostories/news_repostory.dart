import 'package:news/news/data/data_sources/news_data_sources.dart';
import 'package:news/news/data/models/news.dart';

class NewsRepostory {
  NewsDataSources dataSources;

  NewsRepostory(this.dataSources);

  Future<List<News>> getNews(String sourceId, int page, int pageSize) async {
    return dataSources.getNews(sourceId: sourceId, page: page, pageSize: pageSize);
  }

  Future<List<News>> getSearchNews(String query) async {
    return dataSources.getSerachNews(query);
  }
}