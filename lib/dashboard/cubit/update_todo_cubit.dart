// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/common/common_state.dart';
import 'package:todo_app/dashboard/repository/dashboard_repository.dart';

class UpdateTodoCubit extends Cubit<CommonState> {
  final DashboardRepository repository;
  UpdateTodoCubit({
    required this.repository,
  }) : super(CommonInitialState());

  updateTodo({required String? docId, required String? title}) async {
    emit(CommonLoadingState());

    final res = await repository.updateTodo(
      docId: docId,
      title: title,
    );
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
