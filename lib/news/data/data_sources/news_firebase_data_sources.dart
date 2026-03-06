import 'package:news/news/data/data_sources/news_data_sources.dart';
import 'package:news/news/data/models/news.dart';

class NewsFirebaseDataSources implements NewsDataSources {
  @override
  Future<List<News>> getNews({required String sourceId, required int page, required int pageSize}) {
    // firebase logic
    throw UnimplementedError();
  }

  @override
  Future<List<News>> getSerachNews(String query) {
    // firebase logic
    throw UnimplementedError();
  }
  
}