import 'package:news/news/data/data_sources/news_api_data_sources.dart';
import 'package:news/news/data/data_sources/news_data_sources.dart';
import 'package:news/news/data/repostories/news_repostory.dart';
import 'package:news/news/view_model/news_view_model.dart';
import 'package:news/sourses/data/data_sourses/sources_api_data_sources.dart';
import 'package:news/sourses/data/data_sourses/sources_data_sources.dart';
import 'package:news/sourses/data/repostories/sources_repostory.dart';
import 'package:news/sourses/view_model/sources_view_model.dart';

class ServiceLocator {
  static SourcesDataSources sourcesDataSources = SourcesApiDataSources();
  static SourcesRepostory sourcesRepostory = SourcesRepostory(
    sourcesDataSources,
  );
  static SourcesViewModel sourcesViewModel = SourcesViewModel(sourcesRepostory);

  static NewsDataSources newsDataSources = NewsApiDataSources();
  static NewsRepostory newsRepostory = NewsRepostory(newsDataSources);
  static NewsViewModel newsViewModel = NewsViewModel(newsRepostory);
}
