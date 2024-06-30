import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/dashboard/cubit/checkbox_cubit.dart';
import 'package:todo_app/dashboard/cubit/create_todo_cubit.dart';
import 'package:todo_app/dashboard/cubit/delete_todo_cubit.dart';
import 'package:todo_app/dashboard/cubit/fetch_todos_cubit.dart';
import 'package:todo_app/dashboard/cubit/update_todo_cubit.dart';
import 'package:todo_app/dashboard/repository/dashboard_repository.dart';
import 'package:todo_app/dashboard/ui/dashboard_widget.dart';
import 'package:todo_app/login/cubit/sign_out_cubit.dart';
import 'package:todo_app/login/repository/login_repository.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UpdateTodoCubit(repository: context.read<DashboardRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              FetchTodosCubit(repository: context.read<DashboardRepository>())
                ..fetchTodos(
                  userId: user!.displayName!.split(" ").join("_").toLowerCase(),
                ),
        ),
        BlocProvider(
          create: (context) =>
              CreateTodoCubit(repository: context.read<DashboardRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              DeleteTodoCubit(repository: context.read<DashboardRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              SignOutCubit(repository: context.read<LoginRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              CheckboxCubit(repository: context.read<DashboardRepository>()),
        ),
      ],
      child: DashboardWidget(),
    );
  }
}
