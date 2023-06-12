part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object?> get props => [];
}

class ListInitial extends DetailState {}

class ListLoading extends DetailState {}

class ListLoaded extends DetailState {
  final ListModel listModel;
  const ListLoaded(this.listModel);
}

class DetailError extends DetailState {
  final String? message;
  const DetailError(this.message);
}