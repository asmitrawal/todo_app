// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/common/common_state.dart';
import 'package:todo_app/dashboard/repository/dashboard_repository.dart';

class CheckboxCubit extends Cubit<CommonState> {
  DashboardRepository repository;

  CheckboxCubit({
    required this.repository,
  }) : super(CommonInitialState());

  toggleCheckbox({
    required bool isChecked,
    required String? userId,
    required String? docId,
  }) async {
    emit(CommonLoadingState());
    final res = await repository.toggleCheckbox(
      isChecked: isChecked,
      userId: userId,
      docId: docId,
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
