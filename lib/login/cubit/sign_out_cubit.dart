// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/common/common_state.dart';
import 'package:todo_app/login/repository/login_repository.dart';

class SignOutCubit extends Cubit<CommonState> {
  final LoginRepository repository;
  SignOutCubit({
    required this.repository,
  }) : super(CommonInitialState());

  signOut() async {
    emit(CommonLoadingState());

    final res = await repository.SignOut();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState(item: null)),
    );
  }
}
