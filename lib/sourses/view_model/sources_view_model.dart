import 'package:flutter/material.dart';
import 'package:news/sourses/data/data_sourses/sources_data_sources.dart';
import 'package:news/sourses/data/models/source.dart';
import 'package:news/sourses/data/models/sources_response.dart';

class SourcesViewModel with ChangeNotifier {
  SourcesDataSources dataSources = SourcesDataSources();
  List<Source> sources = [];
  String? errorMessage;
  bool isLoading = false;

  Future<void> getSources(String categoryID) async {
    isLoading = true;
    try {
      SourcesResponse response = await dataSources.getSources(categoryID);
      if (response.status == 'ok' && response.sources != null) {
        sources = response.sources!;
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
