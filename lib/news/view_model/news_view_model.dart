import 'package:flutter/material.dart';
import 'package:news/news/data/data_sources/news_data_sources.dart';
import 'package:news/news/data/models/news.dart';
import 'package:news/news/data/models/news_response.dart';

class NewsViewModel with ChangeNotifier {
  NewsDataSources dataSources = NewsDataSources();
  List<News> news = [];
  List<News> searchNews = [];
  String? errorMessage;
  bool isLoading = false;

  Future<void> getNews(String sourceId, int page, int pageSize) async {
    isLoading = true;
    try {
      NewsResponse response = await dataSources.getNews(
        sourceId: sourceId,
        page: page,
        pageSize: pageSize,
      );
      if (response.status == 'ok' && response.news != null) {
        news = response.news!;
      } else {
        errorMessage = 'Failed to get souces';
      }
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getSearchNews(String query) async {
    errorMessage = null;
    searchNews = [];
    isLoading = true;
    try {
      NewsResponse response = await dataSources.getSerachNews(query);
      if (response.status == 'ok' && response.news != null) {
        searchNews = response.news!;
      } else {
        errorMessage = 'Failed to get souces';
      }
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
