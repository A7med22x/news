import 'package:news/models/news_response/news.dart';

class SearchResponse {
  String? status;
  int? totalResults;
  List<News>? news;

  SearchResponse({this.status, this.totalResults, this.news});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      status: json['status'] as String?,
      totalResults: json['totalResults'] as int?,
      news: (json['articles'] as List<dynamic>?)
          ?.map((e) => News.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
