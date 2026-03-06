import 'package:flutter/material.dart';
import 'package:news/news/data/models/news.dart';
import 'package:news/news/data/repostories/news_repostory.dart';

class NewsViewModel with ChangeNotifier {
  NewsRepostory repostory;

  NewsViewModel(this.repostory);

  List<News> news = [];
  List<News> searchNews = [];
  String? errorMessage;
  bool isLoading = false;

  Future<void> getNews(String sourceId, int page, int pageSize) async {
    isLoading = true;
    try {
      news = await repostory.getNews(sourceId, page, pageSize);
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
      searchNews = await repostory.getSearchNews(query);
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
