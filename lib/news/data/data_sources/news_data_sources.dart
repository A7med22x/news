import 'package:news/news/data/models/news.dart';

abstract class NewsDataSources {
  Future<List<News>> getNews({
    required String sourceId,
    required int page,
  });

  Future<List<News>> getSerachNews({String query = '',
    required int page,
  });
}