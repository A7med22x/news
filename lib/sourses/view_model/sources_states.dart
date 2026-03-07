import 'package:news/sourses/data/models/source.dart';

abstract class SourcesState {}

class SourcesInitial extends SourcesState{}

class GetSourcesLoading extends SourcesState{}

class GetSourcesSuccess extends SourcesState{
  List<Source> sources;

  GetSourcesSuccess(this.sources);
}

class GetSourcesError extends SourcesState{
  String errorMessage;

  GetSourcesError(this.errorMessage);
}