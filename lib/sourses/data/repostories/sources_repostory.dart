import 'package:news/sourses/data/data_sourses/sources_data_sources.dart';
import 'package:news/sourses/data/models/source.dart';

class SourcesRepostory {
  SourcesDataSources dataSources;

  SourcesRepostory(this.dataSources);

  Future<List<Source>> getSources(String categoryId) async{
    return dataSources.getSources(categoryId);
  }
}