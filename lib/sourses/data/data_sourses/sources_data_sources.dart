import 'package:news/sourses/data/models/source.dart';

abstract class SourcesDataSources {
  Future<List<Source>> getSources(String categoryID);
}