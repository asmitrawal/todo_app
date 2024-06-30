// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/common/common_state.dart';
import 'package:todo_app/dashboard/repository/dashboard_repository.dart';

class FetchTodosCubit extends Cubit<CommonState> {
  DashboardRepository repository;
  FetchTodosCubit({
    required this.repository,
  }) : super(CommonInitialState());

  fetchTodos({required String userId}) async {
    emit(CommonLoadingState());
    final res = await repository.fetchTodos(userId: userId);
    res.fold(
      (err) {
        emit(CommonErrorState(message: err));
      },
      (data) {
        emit(CommonSuccessState(item: data));
      },
    );
  }

  refreshTodos() async {
    emit(CommonLoadingState());
    final res = await repository.refresh();
    res.fold(
      (err) {
        emit(CommonErrorState(message: err));
      },
      (data) {
        emit(CommonSuccessState(item: data));
      },
    );
  }
}
