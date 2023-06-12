import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:baiki2/model/list/model.dart';
import 'package:baiki2/repository/list/repository.dart';
part 'detail_event.dart';
part 'detail_state.dart';

class ListBloc extends Bloc<DetailEvent, DetailState> {
  ListBloc() : super(ListInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetListList>((event, emit) async {
      try {
        emit(ListLoading());
        final mList = await _apiRepository.fetchListList();
        emit(ListLoaded(mList));
        if (mList.error != null) {
          emit(DetailError(mList.error));
        }
      } on NetworkError {
        emit(const DetailError("Failed to fetch data."));
      }
    });
  }
}