import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/shared/api_constansts.dart';
import 'package:news/news/data/models/news_response.dart';

class NewsDataSources {
  Future<NewsResponse> getNews({
    required String sourceId,
    required int page,
    required int pageSize,
  }) async {
    Uri uri = Uri.https(ApiConstansts.baseUrl, ApiConstansts.newsEndpoint, {
      'apiKey': ApiConstansts.apiKey,
      'sources': sourceId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }

  Future<NewsResponse> getSerachNews(String query) async {
    Uri uri = Uri.https(ApiConstansts.baseUrl, ApiConstansts.searchEndpoint, {
      'apiKey': ApiConstansts.apiKey,
      'q': query,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }
}