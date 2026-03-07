import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news/news/data/models/news.dart';

abstract class NewsState {}

class NewsInitial extends NewsState{}

class GetNewsLoading extends NewsState{}

class GetNewsSuccess extends NewsState{
  List<News> news;

  GetNewsSuccess(this.news);
}

class GetNewsError extends NewsState{
  String errorMessage;

  GetNewsError(this.errorMessage);
}