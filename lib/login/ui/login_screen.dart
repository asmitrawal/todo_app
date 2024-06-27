import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/login/cubit/google_sign_in_cubit.dart';
import 'package:todo_app/login/repository/login_repository.dart';
import 'package:todo_app/login/ui/login_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GoogleSignInCubit(repository: context.read<LoginRepository>()),
      child: LoginWidget(),
    );
  }
}
