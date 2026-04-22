import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/news/data/data_sources/news_data_sources.dart';
import 'package:news/news/data/models/news.dart';
import 'package:news/shared/api_constansts.dart';
import 'package:news/news/data/models/news_response.dart';

class NewsApiDataSources implements NewsDataSources {
  @override
  Future<List<News>> getNews({
    required String sourceId,
    required int page,
  }) async {
    Uri uri = Uri.https(ApiConstansts.baseUrl, ApiConstansts.newsEndpoint, {
      'apiKey': ApiConstansts.apiKey,
      'sources': sourceId,
      'pageSize': '20',
      'page': page.toString(),
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(json);
    if (newsResponse.status == 'ok' && newsResponse.news != null) {
      return newsResponse.news!;
    } else {
      throw Exception('Failed to get news');
    }
  }

  @override
  Future<List<News>> getSerachNews({
    String query = '',
    required int page,
  }) async {
    Uri uri = Uri.https(ApiConstansts.baseUrl, ApiConstansts.searchEndpoint, {
      'apiKey': ApiConstansts.apiKey,
      'q': query,
      'page': page.toString(),
      'pageSize': '20',
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(json);
    if (newsResponse.status == 'ok' && newsResponse.news != null) {
      return newsResponse.news!;
    } else {
      throw Exception('Failed to get news');
    }
  }
}
