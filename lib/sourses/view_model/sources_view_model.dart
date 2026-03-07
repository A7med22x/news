import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/sourses/data/models/source.dart';
import 'package:news/sourses/data/repostories/sources_repostory.dart';
import 'package:news/sourses/view_model/sources_states.dart';

class SourcesViewModel extends Cubit<SourcesState> {
  SourcesRepostory repostory;

  SourcesViewModel(this.repostory) : super(SourcesInitial());

  Future<void> getSources(String categoryId) async {
    emit(GetSourcesLoading());
    try {
      List<Source> sources = await repostory.getSources(categoryId);
      emit(GetSourcesSuccess(sources));
    } catch (error) {
      emit(GetSourcesError(error.toString()));
    }
  }
}
