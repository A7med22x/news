import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/news/data/models/news.dart';
import 'package:news/news/data/repostories/news_repostory.dart';
import 'package:news/news/view_model/news_states.dart';

class NewsViewModel extends Cubit<NewsState> {
  NewsRepostory repostory;

  NewsViewModel(this.repostory) : super(NewsInitial());

  List<News> news = [];

  Future<void> getNews(String sourceId, int page, int pageSize) async {
    emit(GetNewsLoading());
    try {
      if (page == 1) {
        emit(GetNewsLoading());
        news.clear();
      }

      final response = await repostory.getNews(sourceId, page, pageSize);
      news.addAll(response);
      emit(GetNewsSuccess(news));
    } catch (error) {
      emit(GetNewsError(error.toString()));
    }
  }

  Future<void> getSearchNews(String query) async {
    emit(GetNewsLoading());
    try {
      List<News> searchNews = await repostory.getSearchNews(query);
      emit(GetNewsSuccess(searchNews));
    } catch (error) {
      emit(GetNewsError(error.toString()));
    }
  }
}
