import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:baiki2/model/list/model.dart';
import 'package:baiki2/repository/list/repository.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(ListInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetListList>((event, emit) async {
      try {
        emit(ListLoading());
        final mList = await _apiRepository.fetchListList();
        emit(ListLoaded(mList));
        if (mList.error != null) {
          emit(ListError(mList.error));
        }
      } on NetworkError {
        emit(const ListError("Failed to fetch data."));
      }
    });
  }
}