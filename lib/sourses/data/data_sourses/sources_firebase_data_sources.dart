import 'package:news/sourses/data/data_sourses/sources_data_sources.dart';
import 'package:news/sourses/data/models/source.dart';

class SourcesFirebaseDataSources implements SourcesDataSources{
  @override
  Future<List<Source>> getSources(String categoryID) {
    // firebase logic
    throw UnimplementedError();
  }
}