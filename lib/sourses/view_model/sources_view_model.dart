import 'package:flutter/material.dart';
import 'package:news/sourses/data/models/source.dart';
import 'package:news/sourses/data/repostories/sources_repostory.dart';

class SourcesViewModel with ChangeNotifier {
  SourcesRepostory repostory;

  SourcesViewModel(this.repostory);

  List<Source> sources = [];
  String? errorMessage;
  bool isLoading = false;

  Future<void> getSources(String categoryId) async {
    isLoading = true;
    try {
      sources = await repostory.getSources(categoryId);
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
