import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/api/api_constansts.dart';
import 'package:news/models/news_response/news_response.dart';
import 'package:news/models/sources_response/sources_response.dart';

class ApiService {
  static Future<SourcesResponse> getSources(String categoryID) async {
    Uri uri = Uri.https(ApiConstansts.baseUrl, ApiConstansts.sourcesEndpoint, {
      'apiKey': ApiConstansts.apiKey,
      'category': categoryID,
    });

    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return SourcesResponse.fromJson(json);
  }

  static Future<NewsResponse> getNews({required String sourceId, required int page , required int pageSize}) async {
    Uri uri = Uri.https(ApiConstansts.baseUrl, ApiConstansts.newsEndpoint, {
      'apiKey': ApiConstansts.apiKey,
      'sources': sourceId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }
}
