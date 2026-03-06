import 'package:news/news/data/models/news.dart';

abstract class NewsDataSources {
  Future<List<News>> getNews({
    required String sourceId,
    required int page,
    required int pageSize,
  });

  Future<List<News>> getSerachNews(String query);
}