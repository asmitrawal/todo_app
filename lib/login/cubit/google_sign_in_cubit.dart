// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/common/common_state.dart';
import 'package:todo_app/login/repository/login_repository.dart';

class GoogleSignInCubit extends Cubit<CommonState> {
  final LoginRepository repository;
  GoogleSignInCubit({
    required this.repository,
  }) : super(CommonInitialState());

  googleSignIn() async {
    emit(CommonLoadingState());

    final res = await repository.googleSignIn();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState(item: data)),
    );
  }
}
